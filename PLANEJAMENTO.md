# Planejamento do Projeto

## Fase 1 — Fundação Flutter

- Criar projeto Flutter com Material 3.
- Definir tema visual de alto contraste inspirado no material original.
- Criar componentes reutilizáveis: botões grandes, cartões informativos, alertas e barra de progresso. **Concluído na modularização atual.**
- Migrar categorias, aulas e quizzes principais para estruturas Dart. **Concluído, com dados centralizados na feature de aprendizado.**
- Entregar navegação principal por barra inferior.

## Fase 2 — Experiência educacional

- Expandir conteúdo de cada aula com exemplos reais, imagens e vídeos curtos. **Iniciado com aulas específicas de gov.br, PIX, remédios, golpes e internet banking.**
- Melhorar feedback dos quizzes com revisão de erros.
- Adicionar conquistas, medalhas e lembretes de continuidade.
- Criar modo “repetir aula” sem alterar progresso.

## Fase 3 — Acessibilidade avançada

- Implementar leitura em voz alta dos passos.
- Adicionar modo de contraste alternativo e temas de baixa luminosidade.
- Incluir ajuste de espaçamento, tamanho dos botões e fonte para dislexia.
- Testar com usuários idosos e cuidadores.

## Fase 4 — Persistência e segurança

- Salvar progresso localmente.
- Permitir cadastro opcional de nome, contato de emergência e familiar de confiança.
- Adicionar checklist anti-golpe antes de PIX, banco e gov.br.
- Implementar backup/exportação simples dos dados.

## Fase 5 — Integrações

- Abrir apps e sites oficiais com confirmação clara.
- Adicionar mapas, telefone e links de serviços públicos.
- Integrar vídeos oficiais ou curadoria de tutoriais.
- Considerar assistente com IA somente com consentimento e proteção de dados.

## Critérios de aceite da primeira entrega

- O app abre em uma tela de boas-vindas com entrada simples.
- A navegação principal contém Aprender, Apps, Ajuda, Progresso e Perfil.
- O usuário consegue abrir categoria, concluir passos, responder quiz e ver progresso.
- O visual usa fontes grandes, alto contraste e botões fáceis de tocar.
- O projeto contém documentação na raiz, teste básico de widget e testes unitários de aprendizado/progresso.

## Riscos e mitigação

- **Ambiente sem Flutter SDK**: documentar comandos e validar estrutura por revisão de arquivos.
- **Conteúdo sensível de saúde/finanças**: usar linguagem educativa e orientar consulta a profissionais/canais oficiais.
- **Sobrecarga cognitiva**: manter textos curtos, cards grandes e poucas ações por tela.

## Próxima milestone técnica

1. **Arquitetura e estado**
   - Evoluir de `part` files para imports Dart independentes.
   - Manter `AppStateScope` como ponto de injeção de estado para testes e futuras sessões persistidas.
2. **Aprendizado**
   - Usar `LessonSessionController` para centralizar sessão de aula, quiz, pontuação e revisão.
   - Expandir gradualmente os conteúdos que ainda usam `standardSteps` e `standardQuiz`.
3. **Persistência**
   - Implementar `ProgressRepository` persistente com armazenamento local.
   - Salvar progresso, pontuação e preferências de acessibilidade.
4. **Integrações seguras**
   - Transformar `PlannedAppAction` em execução real com confirmação, usando links oficiais, telefone e mapas.
5. **Testes obrigatórios**
   - Manter testes unitários de services/controllers.
   - Adicionar testes de widget para navegação, aula, quiz, perfil e ações de apps.
