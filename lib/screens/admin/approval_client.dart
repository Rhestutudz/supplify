import 'package:flutter/material.dart';
import '../../services/admin_service.dart';

class ApprovalClientScreen extends StatefulWidget {
  const ApprovalClientScreen({super.key});

  @override
  State<ApprovalClientScreen> createState() => _ApprovalClientScreenState();
}

class _ApprovalClientScreenState extends State<ApprovalClientScreen> {
  late Future<List<dynamic>> futureClients;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    futureClients = AdminService.getPendingClients();
  }

  Future<void> _handleApprove(int id) async {
    setState(() => isProcessing = true);

    final res = await AdminService.approveClient(id);

    setState(() => isProcessing = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res['message']),
        backgroundColor: Colors.green,
      ),
    );

    if (res['status'] == true) {
      _loadData();
      setState(() {});
    }
  }

  Future<void> _handleReject(int id) async {
    setState(() => isProcessing = true);

    final res = await AdminService.rejectClient(id);

    setState(() => isProcessing = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res['message']),
        backgroundColor: Colors.red,
      ),
    );

    if (res['status'] == true) {
      _loadData();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Approval Client'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2ECC71),
        elevation: 0,
      ),

      // ================= BODY =================
      body: FutureBuilder<List<dynamic>>(
        future: futureClients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              isProcessing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada client pending',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final clients = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final c = clients[index];
              final int id = c['id'] is int
                  ? c['id']
                  : int.parse(c['id'].toString());

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFF2ECC71),
                        child: Text(
                          c['name'][0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              c['email'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            tooltip: 'Approve',
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            onPressed: () => _handleApprove(id),
                          ),
                          IconButton(
                            tooltip: 'Reject',
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () => _handleReject(id),
                          ),
                        ],
                      )
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
