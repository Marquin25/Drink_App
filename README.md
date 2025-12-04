# Drink_App

## 1. Visão Geral

O Drink_App é um aplicativo Flutter estruturado seguindo o padrão arquitetural **MVVMC (Model–View–ViewModel–Controller)** e organizado com um **Design System próprio**, garantindo consistência visual, modularidade e facilidade de manutenção.
O projeto é dividido em módulos independentes, permitindo evolução e expansão eficiente.

---

## 2. Arquitetura: MVVMC

A arquitetura utilizada segue cinco camadas principais:

### 2.1 Model

Responsável pelas estruturas de dados do aplicativo.
Exemplos: modelos de bebidas, modelos de exibição e resposta.

### 2.2 View

Camada responsável pela interface do usuário. Inclui telas, layouts e widgets visuais.

### 2.3 ViewModel

Gerencia o estado da aplicação, prepara dados para exibição e notifica alterações para a interface.

### 2.4 Controller

Realiza regras de negócio, manipulação de ações do usuário e comunicação com serviços externos (como API).
Atualiza o ViewModel conforme necessário.

### 2.5 Coordinator

Centraliza a navegação entre telas, tornando o fluxo mais organizado e fácil de manter.

---

## 3. Design System

O projeto possui um Design System próprio localizado em:

```
lib/core/design_system/
```

Ele reúne:

### 3.1 Cores

Definidas em:

```
lib/core/design_system/theme/colors.dart
```

Inclui:

* Cores primárias
* Tons escuros e claros
* Escalas de cinza

### 3.2 Tipografia

Definida em:

```
lib/core/design_system/theme/text_styles.dart
```

Contém estilos como:

* button1Bold
* button2Semibold
* button3Semibold
* title
* subtitle

### 3.3 Componentes

Componentes reutilizáveis utilizados em diversas telas, garantindo padronização visual.
Exemplo:

```
DesignSystem/Components/Buttons/ActionButton/
```

---

## 4. Estrutura Geral do Projeto

A estrutura principal segue a separação modular:

```
lib/
 ├── app.dart
 ├── core/
 │    ├── coordinator/
 │    ├── design_system/
 │    └── services/
 ├── modules/
 │    ├── home/
 │    ├── drink/
 │    ├── login/
 └── main.dart
```

---

## 5. Funcionamento do Aplicativo

O fluxo principal segue a lógica:

```
View -> Controller -> Service/API -> ViewModel -> View
```

Descrição:

* A View recebe ações do usuário.
* O Controller interpreta a ação e aplica regras de negócio.
* Caso seja necessário, o Controller aciona serviços externos (como uma API de drinks).
* O Controller atualiza o ViewModel com novos dados.
* O ViewModel notifica a View, que atualiza a interface automaticamente.

### Navegação Centralizada

Toda navegação é gerenciada por:

```
core/coordinator/app_coordinator.dart
```

Isso evita rotas dispersas e facilita a manutenção.

---

## 6. Organização por Módulos

Cada módulo possui:

* view
* viewmodel
* controller
* model

Exemplo:

```
modules/drink/
 ├── drink_details_view.dart
 ├── drink_details_viewmodel.dart
 └── drink_model.dart
```

Essa divisão mantém o código limpo, modular e escalável.

---

## 7. Boas Práticas Utilizadas

* Arquitetura MVVMC aplicada corretamente
* Separação clara entre camadas
* Navegação unificada via Coordinator
* Uso de estados com ChangeNotifier
* Componentes padronizados pelo Design System
* Estrutura modular facilitando manutenção e testes

