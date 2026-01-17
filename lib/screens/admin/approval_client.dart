import 'package:flutter/material.dart';
import '../../services/admin_service.dart';

class ApprovalClientScreen extends StatefulWidget {
  const ApprovalClientScreen({super.key});

  @override
  State<ApprovalClientScreen> createState() =>
      _ApprovalClientScreenState();
}

class _ApprovalClientScreenState extends State<ApprovalClientScreen> {
  late Future<List<dynamic>> futureClients;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    futureClients = AdminService.getPendingClients();
  }

  Future<void> handleApprove(int id) async {
    setState(() => isProcessing = true);

    final res = await AdminService.approveClient(id);

    setState(() => isProcessing = false);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res['message'])));

    if (res['status'] == true) {
      setState(() => loadData());
    }
  }

  Future<void> handleReject(int id) async {
    setState(() => isProcessing = true);

    final res = await AdminService.rejectClient(id);

    setState(() => isProcessing = false);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res['message'])));

    if (res['status'] == true) {
      setState(() => loadData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approval Client')),
      body: FutureBuilder<List<dynamic>>(
        future: futureClients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              isProcessing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Tidak ada client pending'));
          }

          final clients = snapshot.data!;

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final c = clients[index];
              final int id = c['id'] is int
                  ? c['id']
                  : int.parse(c['id'].toString());

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(c['name']),
                  subtitle: Text(c['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check,
                            color: Colors.green),
                        onPressed: () => handleApprove(id),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.close, color: Colors.red),
                        onPressed: () => handleReject(id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
