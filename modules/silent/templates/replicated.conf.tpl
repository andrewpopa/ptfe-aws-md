{
    "DaemonAuthenticationType":     "password",
    "DaemonAuthenticationPassword": "${password}",
    "TlsBootstrapType":             "server-path",
    "TlsBootstrapHostname":         "${fqdn}",
    "TlsBootstrapCert":             "${tls_cert}",
    "TlsBootstrapKey":              "${tls_key}",
    "BypassPreflightChecks":        true,
    "ImportSettingsFrom":           "${settings_file}",
    "LicenseFileLocation":          "${license_file}"
}