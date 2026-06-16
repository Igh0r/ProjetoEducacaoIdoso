# Alterações e Versionamento

Este arquivo registra as versões funcionais do projeto e as principais alterações realizadas em cada etapa.

## v0.1.0 — Protótipo Flutter inicial

- Aplicativo Flutter com Material 3.
- Tela inicial de boas-vindas e login simplificado.
- Navegação inferior com Aprender, Apps, Ajuda, Progresso e Perfil.
- Conteúdo educacional local em memória.
- Progresso e pontuação mantidos apenas durante a sessão.
- Teste básico de widget da tela inicial.

## v0.2.0 — Modularização por features

- Separação do antigo `lib/main.dart` em módulos por responsabilidade.
- Criação de diretórios para `app`, `core`, `features` e `shared`.
- Extração de tema, estado, páginas, modelos, dados seed, repositories, services e widgets compartilhados.
- Inclusão de repositories/services em memória para aprendizado, progresso, assistente e lançador de apps.
- Expansão inicial de aulas específicas sobre gov.br, PIX, remédios, golpes digitais e internet banking.
- Inclusão de testes unitários para progresso e integridade dos dados de aprendizado.
- Atualização de `PROJETO.md` e `PLANEJAMENTO.md` com a nova organização.

## v0.3.0 — Preparação para expansão segura

- Proteção das coleções internas de progresso com retornos imutáveis.
- Criação de `AppStateScope` para permitir injeção de estado pela árvore de widgets.
- Criação de `AccessibilitySettings` e `AccessibilityService` para concentrar preferências de acessibilidade.
- Criação de `LessonSessionController` para separar regras da sessão de aula da UI.
- Criação de `QuizAttempt` para registrar respostas escolhidas, pontuação e data de conclusão.
- Inclusão de revisão final de quiz na conclusão da aula.
- Expansão do conteúdo específico de aulas prioritárias: videochamadas, YouTube, Google Maps, emergência, Meu INSS, SUS online, Imposto de Renda e crédito consignado.
- Criação de `AppRepository`, `AppActionType` e `PlannedAppAction` para preparar integrações seguras com confirmação.
- Ampliação dos testes para sessão de aula, assistente local, ações de apps, acessibilidade e proteção de estado.

## Próximas versões previstas

### v0.4.0 — Persistência local

- Implementar repository persistente com `shared_preferences` ou banco local.
- Salvar aulas concluídas, pontuações e preferências de acessibilidade.
- Adicionar testes com fake storage.

### v0.5.0 — Integrações reais com confirmação

- Integrar `url_launcher` para abrir sites oficiais, telefone e mapas.
- Exibir confirmação clara antes de ações externas.
- Manter comportamento seguro para banco, gov.br, PIX e emergências.

### v0.6.0 — Acessibilidade avançada

- Adicionar leitura em voz alta dos passos.
- Implementar tema de baixa luminosidade e opções de espaçamento.
- Avaliar fonte amigável para dislexia e escala de botões.
