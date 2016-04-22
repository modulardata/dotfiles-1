{% if grains.os_family == 'Debian' %}
fonts-requirements:
    pkg.installed:
        - pkgs:
            - xfonts-utils

fonts-hack-clone:
    git.latest:
        - name: https://github.com/chrissimpkins/Hack.git
        - target: /opt/fonts-hack
        - depth: 1

fonts-hack-copy-files:
    cmd.run:
        - name: cp -R /opt/fonts-hack/build/ttf /usr/share/fonts/truetype/hack

fonts-hack-install:
    cmd.run:
        - name: fc-cache -s; mkfontscale /usr/share/fonts/truetype/hack; mkfontdir /usr/share/fonts/truetype/hack
        - require:
            - pkg: fonts-requirements

fonts-nerd-fonts:
    git.latest:
        - name: https://github.com/ryanoasis/nerd-fonts.git
        - target: /opt/fonts-nerd-fonts
        - depth: 1

foints-nerd-fonts-install:
    cmd.run:
        - name: ./install.sh
        - cwd: /opt/fonts-nerd-fonts
        - require:
            - git: fonts-nerd-fonts
{% else %}
{% endif %}

