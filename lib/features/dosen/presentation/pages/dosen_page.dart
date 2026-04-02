import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/features/dosen/data/models/dosen_model.dart';
import 'package:cobadulu/features/dosen/presentation/providers/dosen_provider.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Data Dosen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
              ref.invalidate(savedUsersProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dosenNotifierProvider);
          ref.invalidate(savedUsersProvider);
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            const SizedBox(height: 12),
            _SavedUserSection(savedUsers: savedUsers),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Daftar Dosen',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            dosenState.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              data: (list) => _DosenListWithSave(
                dosenList: list,
                onRefresh: () async {
                  ref.invalidate(dosenNotifierProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedUserSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;

  const _SavedUserSection({required this.savedUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.storage_rounded, size: 16),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'Data Tersimpan di Local Storage',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  savedUsers.when(
                    data: (users) => users.isNotEmpty
                        ? TextButton.icon(
                      onPressed: () async {
                        await ref
                            .read(dosenNotifierProvider.notifier)
                            .clearSavedUsers();
                        ref.invalidate(savedUsersProvider);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Semua data tersimpan dihapus'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete_sweep_outlined,
                        size: 14,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Hapus Semua',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              savedUsers.when(
                loading: () => const LinearProgressIndicator(minHeight: 2),
                error: (_, __) => const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Gagal membaca data tersimpan',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
                data: (users) {
                  if (users.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Belum ada data tersimpan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(users.length, (index) {
                      final user = users[index];
                      final isLast = index == users.length - 1;

                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.green.shade100,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['username'] ?? '-',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await ref
                                      .read(dosenNotifierProvider.notifier)
                                      .removeSavedUser(user['user_id'] ?? '');
                                  ref.invalidate(savedUsersProvider);

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${user['username']} dihapus',
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          if (!isLast)
                            Divider(
                              height: 16,
                              color: Colors.green.shade100,
                            ),
                        ],
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(String isoString) {
  if (isoString.isEmpty) return '-';
  try {
    final date = DateTime.parse(isoString);
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    return '${date.day}/${date.month}/${date.year} $hh:$mm';
  } catch (_) {
    return isoString;
  }
}

class _DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;
  final Future<void> Function() onRefresh;

  const _DosenListWithSave({
    required this.dosenList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dosenList.length,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      itemBuilder: (context, index) {
        final dosen = dosenList[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                '${dosen.id}',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            title: Text(
              dosen.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              '${dosen.username} • ${dosen.email}\n${dosen.address.city}',
              style: const TextStyle(fontSize: 12),
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.save, size: 18),
              tooltip: 'Simpan user ini',
              onPressed: () async {
                await ref
                    .read(dosenNotifierProvider.notifier)
                    .saveSelectedDosen(dosen);
                ref.invalidate(savedUsersProvider);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${dosen.username} berhasil disimpan ke local storage',
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}