# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  istio_gateway_domains = keys(var.gateway_dns)

  preconfigured_waf_rules = [
    # Google Cloud Armor provides preconfigured WAF rules, each consisting of multiple signatures sourced from:
    # https://github.com/coreruleset/coreruleset/releases/tag/v3.3.3

    # Each signature has a sensitivity level that corresponds to a ModSecurity paranoia level. You can select a
    # sensitivity between 0 and 4, though sensitivity level 0 means that no rules are enabled by default.
    # A lower sensitivity level indicates higher confidence signatures, which are less likely to generate a false positive.
    # A higher sensitivity level increases security, but also increases the risk of generating a false positive.

    {
      name        = "sqli-v33-stable"
      action      = "deny(403)"
      description = "OWASP: SQL injection"
      preview     = false
      priority    = 10000
      sensitivity = 1
    },
    {
      name        = "xss-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Cross-site scripting"
      preview     = false
      priority    = 10010
      sensitivity = 1
    },
    {
      name        = "lfi-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Local file inclusion"
      preview     = false
      priority    = 10020
      sensitivity = 1
    },
    {
      name        = "rfi-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Remote file inclusion"
      preview     = false
      priority    = 10030
      sensitivity = 1
    },
    {
      name        = "rce-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Remote code execution"
      preview     = false
      priority    = 10040
      sensitivity = 1
    },
    {
      name        = "methodenforcement-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Method enforcement"
      preview     = false
      priority    = 10050
      sensitivity = 1
    },
    {
      name        = "scannerdetection-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Scanner detection"
      preview     = false
      priority    = 10060
      sensitivity = 1
    },
    {
      name        = "protocolattack-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Protocol attack"
      preview     = false
      priority    = 10070
      sensitivity = 1
    },
    {
      name        = "php-v33-stable"
      action      = "deny(403)"
      description = "OWASP: PHP injection attack"
      preview     = false
      priority    = 10080
      sensitivity = 1
    },
    {
      name        = "sessionfixation-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Session fixation"
      preview     = false
      priority    = 10090
      sensitivity = 1
    },
    {
      name        = "java-v33-stable"
      action      = "deny(403)"
      description = "OWASP: Java attack"
      preview     = false
      priority    = 10100
      sensitivity = 1
    },
    {
      name        = "nodejs-v33-stable"
      action      = "deny(403)"
      description = "OWASP: NodeJS attack"
      preview     = false
      priority    = 10110
      sensitivity = 1
    },

    # Additional rules that detect and optionally block the following
    # vulnerabilities:

    # CVE-2021-44228 and CVE-2021-45046 Log4j RCE vulnerabilities
    # 942550-sqli JSON-formatted content vulnerability

    {
      name        = "cve-canary"
      action      = "deny(403)"
      description = "Log4j vulnerability"
      preview     = false
      priority    = 10120
      sensitivity = 1
    },
    {
      name        = "json-sqli-canary"
      action      = "deny(403)"
      description = "JSON-based SQL injection bypass vulnerability"
      preview     = false
      priority    = 10130
      sensitivity = 1
    }
  ]
}
