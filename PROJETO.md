# Educação para Idosos — Aplicativo Flutter

## Visão geral

Este projeto transforma o material original da pasta `sourceMaterial` em um aplicativo Flutter com foco em educação, autonomia digital e acessibilidade para pessoas idosas. O design foi mantido simplificado, com fundo escuro, alto contraste, botões grandes, textos amplos, emojis ilustrativos e navegação inferior curta.

## Objetivos

- Ensinar tecnologia, saúde, cidadania digital, finanças, idiomas e hobbies com linguagem simples.
- Oferecer aulas em passos curtos, com dicas, alertas e quizzes de fixação.
- Simular um lançador de aplicativos úteis para comunicação, entretenimento, serviços e emergência.
- Incluir um assistente digital local com respostas rápidas sobre temas comuns.
- Acompanhar progresso de aulas concluídas, pontuação de quiz e tempo estimado de estudo.
- Disponibilizar ajustes de acessibilidade, como tamanho do texto e alto contraste.

## Principais telas

1. **Login simplificado**: entrada direta para reduzir atrito em demonstrações.
2. **Aprender**: lista categorias e progresso geral.
3. **Categoria**: mostra aulas do tema selecionado.
4. **Aula**: apresenta passos guiados, dicas, alertas e quiz.
5. **Meus Aplicativos**: grade de apps úteis com mensagens educativas e números de emergência.
6. **Assistente Digital**: chat local para dúvidas frequentes sobre segurança, PIX, gov.br e remédios.
7. **Progresso**: resumo de aulas concluídas, minutos estudados e histórico.
8. **Perfil**: ajustes de acessibilidade e saída.

## Estrutura técnica

```text
lib/main.dart             # Aplicativo Flutter, telas, modelos, dados e componentes reutilizáveis.
pubspec.yaml              # Metadados e dependências Flutter.
analysis_options.yaml     # Regras de lint para qualidade de código.
test/widget_test.dart     # Teste básico de renderização da tela inicial.
sourceMaterial/           # Material React/Figma original usado como referência.
PROJETO.md                # Descrição completa do produto e arquitetura.
PLANEJAMENTO.md           # Plano de evolução e entregas.
```

## Dependências

- `flutter` SDK.
- `cupertino_icons` para compatibilidade com ícones iOS.
- `flutter_lints` para análise estática.
- `flutter_test` para testes de widget.

## Como executar

> É necessário ter o Flutter SDK instalado no ambiente local.

```bash
flutter pub get
flutter run
```

## Como validar

```bash
flutter analyze
flutter test
```

## Decisões de design

- **Sem login real** nesta primeira entrega: reduz complexidade e facilita uso por idosos em protótipos.
- **Estado em memória**: progresso dura durante a sessão. Persistência local pode ser adicionada na próxima fase.
- **Conteúdo local**: aulas e quizzes ficam embutidos para funcionar offline e sem conta externa.
- **Sem IA externa**: o assistente usa respostas locais para evitar custo, latência e dependência de internet.

## Próximas melhorias sugeridas

- Persistir progresso com `shared_preferences` ou banco local.
- Adicionar leitura em voz alta e comandos por voz.
- Integrar abertura real de aplicativos/links com `url_launcher`.
- Criar onboarding para cadastro de familiar/cuidador.
- Separar `lib/main.dart` em módulos (`models`, `data`, `screens`, `widgets`) conforme o app crescer.
