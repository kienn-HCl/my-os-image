# My-OS-image &nbsp; [![bluebuild build badge](https://github.com/kienn-HCl/my-os-image/actions/workflows/build.yml/badge.svg)](https://github.com/blue-build/template/actions/workflows/build.yml)

## BlueBuild Template 
This repository use BlueBuild Template.
See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/kienn-hcl/my-os-image:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/kienn-hcl/my-os-image:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/kienn-hcl/my-os-image
```

## Trouble
### ブート時、ディスク複合のパスワード入力画面でus配列となってしまう。
カーネルパラメータに`vconsole.keymap=jp`を追加する。その後リブート。
次のコマンドでカーネルパラメータを編集できる。
```bash
rpm-ostree kargs --editor
```

参考: [LUKS unlock screen always uses en-US keyboard layout · Issue #3 · fedora-silverblue/issue-tracker](https://github.com/fedora-silverblue/issue-tracker/issues/3)
