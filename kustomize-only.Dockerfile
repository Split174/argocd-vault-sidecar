FROM registry.access.redhat.com/ubi9/ubi:9.5

USER root

ENV KUSTOMIZE_VERSION=5.5.0 \
    AGE_VERSGION=1.2.0 \
    SOPS_VERSION=3.9.1 \
    AVP_VERSION=1.18.1

# Install git and friends
RUN dnf -y install \
    bash tar gzip unzip which findutils git && \
    dnf -y -q clean all && rm -rf /var/cache/yum && \
    echo "🐙🐙🐙🐙🐙"

# Install the AVP plugin
RUN curl -skL -o /tmp/argocd-vault-plugin https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64 && \
    chmod +x /tmp/argocd-vault-plugin && \
    mv -v /tmp/argocd-vault-plugin /usr/local/bin && \
    echo "🔒🔒🔒🔒"

# Install kustomize
RUN curl -skL -o /tmp/kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar -C /tmp -xzf /tmp/kustomize.tar.gz && \
    mv -v /tmp/kustomize /usr/local/bin && \
    chmod -R 775 /usr/local/bin/kustomize && \
    rm -rf /tmp/linux-amd64 && \
    echo "🐾🐾🐾🐾🐾"

# Install age
RUN curl -skL -o /tmp/age.tar.gz https://github.com/FiloSottile/age/releases/download/v${AGE_VERSGION}/age-v${AGE_VERSGION}-linux-amd64.tar.gz && \
    tar -C /tmp -xzf /tmp/age.tar.gz && \
    mv -v /tmp/age/age /usr/local/bin && \
    mv -v /tmp/age/age-keygen /usr/local/bin && \
    chmod -R 775 /usr/local/bin/age && \
    chmod -R 775 /usr/local/bin/age-keygen && \
    rm -rf /tmp/age && \
    echo "🪩🪩🪩🪩🪩"

# Install sops
RUN curl -skL -o /usr/local/bin/sops https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64 && \
    chmod -R 775 /usr/local/bin/sops && \
    echo "🎤🎤🎤🎤🎤"

USER 999
