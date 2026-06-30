void main() {
  testWidgets(
    'Tela de categorias apresenta os itens corretamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Categorias de Aprendizado'),
            ),
            body: ListView(
              children: const [
                ListTile(title: Text('Saúde')),
                ListTile(title: Text('Tecnologia')),
                ListTile(title: Text('Leitura')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Categorias de Aprendizado'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Saúde'), findsOneWidget);
      expect(find.text('Tecnologia'), findsOneWidget);
      expect(find.text('Leitura'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(3));
      expect(tester.takeException(), isNull);
    },
  );
}