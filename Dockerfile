# Utilisez une image de base "from scratch" vide
FROM scratch

# Importe les fichiers de base Arch Linux depuis un tarball
ADD archlinux-bootstrap-2023.05.03-x86_64.tar.gz / 

# Configure les variables d'environnement pour l'installation de Pacman
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Met à jour la base de données des paquets et installe les paquets de base
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm bash pacman

# Configure Pacman pour qu'il ne demande pas de confirmation lors des installations
RUN sed -i 's/#\(\[options\]\)/\1\nSigLevel = Never/' /etc/pacman.conf && \
    sed -i 's/#\(\[options\]\)/\1\nCheckSpace = false/' /etc/pacman.conf && \
    sed -i 's/#\(\[options\]\)/\1\nILoveCandy/' /etc/pacman.conf

# Définit /bin/bash comme shell par défaut pour l'image
SHELL ["/bin/bash", "--login", "-c"]

# Commande par défaut pour lancer un shell interactif
CMD ["/bin/bash"]
