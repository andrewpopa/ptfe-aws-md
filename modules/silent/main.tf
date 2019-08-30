data "template_file" "application-settings" {
  template = "${file("${path.module}/templates/application-settings.json.tpl")}"

  vars = {
    hostname     = "${var.fqdn}"
    enc_password = "${var.dashboard_password}"
    disk         = "${var.disk}"
  }
}

data "template_file" "replicated" {
  template = "${file("${path.module}/templates/replicated.conf.tpl")}"

  vars = {
    password      = "${var.dashboard_password}"
    settings_file = "/tmp/application-settings.json"
    license_file  = "/tmp/license.rli"
    fqdn          = "${var.fqdn}"
    tls_cert      = "/tmp/fullchain1.pem"
    tls_key       = "/tmp/privkey1.pem"
  }
}

resource "null_resource" "silent" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = "${var.public_ip}"
    private_key = "${file("cert.pem")}"
  }
  provisioner "file" {
    content     = "${data.template_file.replicated.rendered}"
    destination = "/tmp/replicated.conf"
  }

  provisioner "file" {
    content     = "${data.template_file.application-settings.rendered}"
    destination = "/tmp/application-settings.json"
  }

  provisioner "file" {
    content     = "${file("${path.module}/files/fullchain1.pem")}"
    destination = "/tmp/fullchain1.pem"
  }

  provisioner "file" {
    content     = "${file("${path.module}/files/privkey1.pem")}"
    destination = "/tmp/privkey1.pem"
  }
  provisioner "file" {
    source      = "${path.module}/files/hashicorp-andrei-popa---tam.rli"
    destination = "/tmp/hashicorp-andrei-popa---tam.rli"
  }

  provisioner "file" {
    source      = "${path.module}/files/silent_restore.sh"
    destination = "/tmp/silent_restore.sh"
  }
  provisioner "remote-exec" {
    inline = [<<EOF
      sudo cp /tmp/replicated.conf /etc/replicated.conf
      sudo curl -o /tmp/install.sh https://install.terraform.io/ptfe/stable
      sudo chmod +x /tmp/install.sh
      while :; 
      do 
        mountpoint -q /mountdisk || echo "/mountdisk not mounted"
        mountpoint -q /var/lib/replicated/snapshots || echo "/snapshots not mounted" 
        mountpoint -q /mountdisk && mountpoint -q /var/lib/replicated/snapshots && {
            break;
        }
        sleep 1; 
      done
      df -Ph
      [ -f /var/lib/replicated/snapshots/files/db.dump ] && {
        echo "Restoring everything from backup"
        sudo chmod +x /tmp/silent_restore.sh
        sudo bash /tmp/silent_restore.sh
      }

      [ -f /var/lib/replicated/snapshots/files/db.dump ] || {
        echo "Performing fresh installation in silent mode"
        sudo bash /tmp/install.sh no-proxy private-address=${var.private_ip} public-address=${var.public_ip}       
      }
      EOF
    ]
  }
}