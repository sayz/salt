change_shell:
    module.run:
        - name: user.chshell
        - m_name: {{ salt['pillar.get']('oh-my-zsh:user:name', sayz) }}
        - shell: /usr/bin/zsh
        - unless: /usr/bin/grep {{ salt['pillar.get']('oh-my-zsh:user:name', sayz) }} /etc/passwd | /usr/bin/grep zsh

https://github.com/robbyrussell/oh-my-zsh.git:
    git.latest:
        - rev: master
        - target: "{{ salt['pillar.get']('oh-my-zsh:user:home', '/home/sayz') }}/.oh-my-zsh"
        - unless: "test -d {{ salt['pillar.get']('oh-my-zsh:user:home', '/home/sayz') }}/.oh-my-zsh"

.zshrc:
    file.managed:
        - name: "{{ salt['pillar.get']('oh-my-zsh:user:home', '/home/sayz') }}/.zshrc"
        - source: salt://oh-my-zsh/files/.zshrc
        - user: {{ salt['pillar.get']('oh-my-zsh:user:name', sayz) }}
{% if grains['os'] == 'SUSE' %}
        - group: 'users'
{% else %}
        - group: {{ salt['pillar.get']('oh-my-zsh:user:group', sayz) }}
{% endif %}
        - mode: '0644'
        - template: jinja
