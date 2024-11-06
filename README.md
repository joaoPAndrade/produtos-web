# Produtos Web

Este projeto é uma aplicação web para gerenciar produtos, desenvolvida com o framework Flutter. A aplicação permite adicionar, editar, visualizar e excluir produtos.

## Pré-requisitos

Certifique-se de que você possui:

- **Flutter** instalado e configurado (incluindo o suporte para Web e Linux, se desejar executar em ambas as plataformas).
- **Git** para clonar o repositório.

Para verificar se seu ambiente Flutter está corretamente configurado, execute:

```bash
flutter doctor
```

## Passos para Instalação

1. **Clone o repositório**:

   ```bash
   git clone https://github.com/joaoPAndrade/produtos-web.git
   cd produtos-web/produtos_web
   ```

2. **Instale as dependências**:

   Execute o seguinte comando para resolver as dependências do projeto:

   ```bash
   flutter pub get
   ```

## Executando a Aplicação

### Para Web

1. Certifique-se de que o Flutter está configurado para compilar para Web. Você pode verificar os dispositivos disponíveis para execução com:

   ```bash
   flutter devices
   ```

   O dispositivo "Chrome" deve aparecer na lista para execução no navegador.

2. Execute o projeto com o comando abaixo:

   ```bash
   flutter run -d chrome
   ```

   Isso abrirá o aplicativo no navegador padrão usando o Chrome como destino.

### Para Linux

1. Certifique-se de que o Flutter está configurado para compilar para Linux. Caso o suporte ao Linux não esteja habilitado, você pode ativá-lo com:

   ```bash
   flutter config --enable-linux-desktop
   ```

2. Verifique se o Linux está listado entre os dispositivos disponíveis:

   ```bash
   flutter devices
   ```

   O dispositivo "Linux" deve aparecer na lista se o suporte ao Linux estiver corretamente configurado.

3. Execute o projeto com o comando abaixo:

   ```bash
   flutter run -d linux
   ```

   Isso abrirá o aplicativo em uma janela de desktop no Linux.

