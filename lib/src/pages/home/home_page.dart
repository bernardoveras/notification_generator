import 'package:flutter/material.dart';
import '../../enums/notification_type_enum.dart';
import '../../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final notificationService = NotificationService();
  final formKey = GlobalKey<FormState>();

  String tituloDaNotificacao = '';
  void setTituloDaNotificacao(String value) => tituloDaNotificacao = value;

  String descricaoDaNotificacao = '';
  void setDescricaoDaNotificacao(String value) =>
      descricaoDaNotificacao = value;

  NotificationIcon? iconeDaNotificacao;
  void setIconeDaNotificacao(NotificationIcon value) =>
      iconeDaNotificacao = value;

  Future<void> submit() async {
    if (formKey.currentState?.validate() != true) return;

    notificationService.show(
      title: tituloDaNotificacao,
      description: descricaoDaNotificacao,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green.shade600,
        content: const Text('Notificação enviada com sucesso.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de notificações'),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
        ),
        width: double.infinity,
        child: SizedBox(
          height: 55,
          child: FilledButton(
            onPressed: submit,
            child: const Text('Enviar notificação'),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Wrap(
                runSpacing: 16,
                children: [
                  Text(
                    'Detalhes da notificação:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Título *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'Digite um título para a notificação.';
                      }
                      return null;
                    },
                    onChanged: setTituloDaNotificacao,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (value) => submit(),
                    decoration: const InputDecoration(
                      labelText: 'Descrição *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'Digite uma descrição para a notificação.';
                      }
                      return null;
                    },
                    onChanged: setDescricaoDaNotificacao,
                  ),
                  DropdownButtonFormField(
                    items: NotificationIcon.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.title),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Ícone *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Selecione um ícone para a notificação.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
