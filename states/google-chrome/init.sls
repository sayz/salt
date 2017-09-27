{% if grains['os_family'] in ['RedHat','Suse'] %}
key-install:
 cmd.run:
  - name: "/bin/rpm --import https://dl.google.com/linux/linux_signing_key.pub"
  - unless: "/bin/rpm -qi gpg-pubkey-* | grep google"
pkg-install:
 cmd.run:
  - name: "rpm -Uvh https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
  - unless: "/bin/rpm -qa | grep google-chrome"

{% elif grains['os_family'] == 'Debian' %}

key-install:
 cmd.run:
  - name: echo "TODO"

pkg-install:
 cmd.run:
  - name: echo "TODO"
{% endif %}
