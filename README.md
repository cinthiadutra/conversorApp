# 💱 ConversorApp

Aplicativo Flutter de conversão de moedas com autenticação de usuários e histórico de conversões. Desenvolvido com **GetX**, **MySQL** e arquitetura limpa.

---

## 📱 Funcionalidades

- ✅ Conversão entre moedas (BRL, USD, CAD)
- ✅ Autenticação de usuário (Login e Cadastro)
- ✅ Armazenamento e exibição do histórico de conversões
- ✅ Tema claro/escuro com toggle
- ✅ Persistência de dados com MySQL

---

## 🚀 Tecnologias Utilizadas

- [Flutter](https://flutter.dev)
- [GetX](https://pub.dev/packages/get)
- [MySQL](https://www.mysql.com)
- [mysql_client](https://pub.dev/packages/mysql_client)
- [Get CLI](https://pub.dev/packages/get_cli)

---

## 🛠️ Estrutura do Projeto

lib/
├── controllers/ # GetX Controllers (Login, Conversão, Tema)
├── models/ # Models para usuário e conversão
├── services/ # DatabaseService e ApiService
├── utils/ # Rotas e constantes
└── views/ # Telas de Login, Cadastro, Home
test/
├── controllers/ # Testes unitários dos controllers
├── services/ # Testes de integração dos serviços
└── views/ # Testes de widget das telas

## ⚙️ Como Rodar o Projeto

### 1. Requisitos

- Flutter 3.x
- MySQL Server local ou remoto

### 2. Clonar o repositório

git clone https://github.com/seu-usuario/conversor_app.git
cd conversor_app


### 3. Instalar dependências

flutter pub get

### 4. Configurar Banco de Dados
Crie um banco chamado conversor_db e execute o seguinte script:

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE conversions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  from_currency VARCHAR(3),
  to_currency VARCHAR(3),
  amount DOUBLE,
  result DOUBLE,
  rate DOUBLE,
  date DATETIME
);
Atualize as credenciais em lib/services/database_service.dart.

### 5. Executar o App

flutter run

### 6. Rodar os Testes

![image](https://github.com/user-attachments/assets/81b36945-4ff4-4bdb-af55-919e1fb1fa10)
![image](https://github.com/user-attachments/assets/a0a018ac-2c2d-4013-8dc3-6daff644776a)
![image](https://github.com/user-attachments/assets/9d7e2b34-1305-4d8a-9645-76b6860f4b25)



