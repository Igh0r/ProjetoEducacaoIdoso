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
lib/main.dart                                      # Bootstrap, imports e composição dos módulos.
lib/app/theme/                                    # Tema visual, cores e Material 3.
lib/core/state/                                   # Estado de sessão e orquestração de progresso.
lib/features/auth/presentation/                   # Tela de entrada simplificada.
lib/features/navigation/presentation/             # Navegação inferior principal.
lib/features/learning/models/                     # Modelos de aula, categoria, passo e quiz.
lib/features/learning/data/                       # Conteúdo local das aulas e quizzes.
lib/features/learning/repositories/               # Contratos e fonte local de aulas.
lib/features/learning/presentation/               # Telas e widgets da seção Aprender.
lib/features/apps/models|data|services|presentation/ # Lançador educativo de apps úteis.
lib/features/assistant/models|services|presentation/ # Assistente local com respostas determinísticas.
lib/features/progress/repositories|services|presentation/ # Persistência SQLite de progresso e cálculos de estudo.
lib/features/profile/presentation/                # Ajustes de acessibilidade.
lib/shared/widgets/                               # Componentes reutilizáveis para idosos.
test/features/                                    # Testes unitários de progresso e aprendizado.
test/widget_test.dart                             # Teste básico de renderização da tela inicial.
sourceMaterial/                                   # Material React/Figma original usado como referência.
```

> Observação: os módulos Flutter foram separados em arquivos por feature e camada, preservando o comportamento do protótipo. O progresso das aulas agora usa um repository SQLite local, mantendo a camada de repository/service preparada para futuras evoluções de armazenamento.

## Camadas

- **Models**: representam entidades simples, como `Lesson`, `LessonCategory`, `LessonStep`, `QuizQuestion`, `AppItem` e `ChatMessage`.
- **Data**: concentra dados locais de aulas, quizzes e grupos de apps úteis.
- **Repositories**: abstraem acesso a dados. O progresso usa SQLite local, enquanto conteúdos de aulas e apps continuam em dados locais.
- **Services**: concentram regras reutilizáveis, como cálculo de progresso, resposta do assistente e mensagens do lançador de apps.
- **Presentation**: contém telas e widgets de cada feature.
- **Shared widgets**: reúne componentes acessíveis e reutilizáveis, como botões grandes, cards informativos, alertas e banner de progresso.

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

## Como adicionar uma nova aula

1. Abra `lib/features/learning/data/lesson_seed_data.dart`.
2. Escolha a categoria adequada em `categories`.
3. Adicione um novo `Lesson` com `id` único, título, descrição, duração, passos e quiz.
4. Use passos curtos, dicas práticas e avisos quando houver risco de segurança, saúde ou dinheiro.
5. Execute os testes para garantir IDs únicos e conteúdo mínimo.

## Como adicionar um novo app útil

1. Abra `lib/features/apps/data/app_seed_data.dart`.
2. Adicione um `AppItem` no grupo apropriado.
3. Defina rótulo curto, emoji, cor e mensagem educativa.
4. Se houver abertura real de links/apps no futuro, implemente a regra em `AppLaunchService`.

## Decisões de design

- **Sem login real** nesta primeira entrega: reduz complexidade e facilita uso por idosos em protótipos.
- **Persistência local com SQLite**: progresso e pontuações de quiz são carregados de um banco local ao iniciar o app e atualizados quando uma aula é concluída.
- **Conteúdo local**: aulas e quizzes ficam embutidos para funcionar offline e sem conta externa.
- **Sem IA externa**: o assistente usa respostas locais para evitar custo, latência e dependência de internet.

## Próximas melhorias sugeridas

- Adicionar leitura em voz alta e comandos por voz.
- Integrar abertura real de aplicativos/links com `url_launcher`.
- Criar onboarding para cadastro de familiar/cuidador.
- Adicionar revisão detalhada de erros do quiz com histórico por tentativa.
