# simply virtual machine provisioner for network learning

## これはなに

Cumulus VXを使ったネットワーク学習用のリポジトリ

## 必要なもの

-  Vagrant
-  VirtualBox
-  構成に応じたストレージ容量

## 構成

それぞれ`Vagrantfile`を書き換えることでカスタマイズできる

### spine, leafスイッチ

- Cumulus VX (Cumulus Linux)
- spine, leafスイッチは各2つ立ち上がるようになっている (spine-1, spine-2, leaf-1, leaf-2)
- 仮想NICはspine, leafスイッチともに36個まで (マネジメントポート含む)

### サーバ

- Ubuntu 18.04
- 2つのノードが立ち上がるようになっている (node-1_1, node-2_1)
- 仮想NICは8つまで (マネジメントポート含む)

## つかいかた

1. `vagrant up` (virtualboxでは`--parallel`オプションはサポートされていない)
2. `vagrant ssh <スイッチorノード>`
3. スイッチなら`sudo net`で設定，または`sudo vtysh`でIOSっぽいターミナルに入れる

スイッチの場合，いちいち`sudo`つけるのが面倒なら`cumulus`アカウントに切り替える必要があるので`sudo login`で切り替える(アカウント/パスワードは`cumulus/CumulusLinux!`)