# base image légère mne-tools
FROM ghcr.io/mne-tools/mne-python-plot:v0.23.0

# runtime Qt
RUN mkdir -p /tmp/runtime-mne_user && chmod 777 /tmp/runtime-mne_user
ENV XDG_RUNTIME_DIR=/tmp/runtime-mne_user


# scikit-learn compatible
RUN pip install scikit-learn==1.0.2

# choisir backend 3D MNE par défaut
RUN python3 - << 'EOF'
import mne
mne.viz.set_3d_backend('pyvista')
EOF


# make workdir
RUN mkdir -p /home/mne_user/work
WORKDIR /home/mne_user/work

# command to launch JLab directly in work dir
CMD ["jupyter-lab", "--ip=0.0.0.0", "--no-browser", "--ServerApp.root_dir=/home/mne_user/work", "--ServerApp.token="]
