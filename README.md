# create_ap

Esse repositório contém um script feito em [bashly](bashly.dev) que simplifica o uso do [lnxrouter](https://github.com/garywill/linux-router/blob/master/lnxrouter).

## Instalação

1. Clonar o repositório

2. Instalar

```bash
sudo make install
```

## Como usar

1. Crie um arquivo de configuração `config.json`

```json
{
  "hostname": "ap_name",
  "password": "ap_password",
  "interface_fullname": "Broadcom BCM4354 WLAN card"
}
```

> `interface_fullname` é o nome completo da interface wifi. 
> Ele pode ser obtido usando o comando `create_ap list`


2. Inicie o Hotspot wifi

```bash
sudo create_ap start --config config.json
```

3. Pare o Hotspot wifi

```bash
sudo create_ap stop
```

> Caso tenha dúvida com algum comando, execute `create_ap --help`
