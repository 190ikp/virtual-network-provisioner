# simply virtual machine provisioner for network learning

## これはなに

Cumulus VXを使ったネットワーク学習用のリポジトリ

## 必要なもの

-  Vagrant
-  VirtualBox
-  GNS3 (<-あるといいかも)

## 構成

それぞれ`Vagrantfile`を書き換えることでカスタマイズできる

### spine, leafスイッチ

- Cumulus VX (Cumulus Linux)
- spineスイッチは2つ, leafスイッチは3つ立ち上がるようになっている(spine-1, spine-2, leaf-1, ..., leaf-3)
- それぞれ仮想NICはswp1-swp4の4つ(+VirtualBoxのNAT用NIC)

### サーバ

- Ubuntu 18.04
- 3つのノードが立ち上がるようになっている(node-1, ..., node-3)
- 仮想NICはeth0, eth1の2つ(+VirtualBoxのNAT用NIC)

## つかいかた

1. `vagrant up`
2. `vagrant ssh <スイッチorノード>`
3. スイッチの場合，`cumulus`アカウントに切り替える必要があるので`sudo login`で切り替える(アカウント/パスワードは`cumulus/CumulusLinux!`)