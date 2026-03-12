// lib/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/core/widgets/common_widgets.dart';
import 'package:cobadulu/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:cobadulu/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerStatefulWidget {
  const MahasiswaAktifPage({super.key});

  @override
  ConsumerState<MahasiswaAktifPage> createState() => _MahasiswaAktifPageState();
}

class _MahasiswaAktifPageState extends ConsumerState<MahasiswaAktifPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mahasiswaState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifNotifierProvider),
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: _buildSearchField(),
          ),
        ),
      ),
      body: SafeArea(
        child: mahasiswaState.when(
          loading: () => const LoadingWidget(),
          error: (err, st) => CustomErrorWidget(
            message: 'Gagal memuat mahasiswa aktif: ${err.toString()}',
            onRetry: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
          ),
          data: (stateData) {
            final list = stateData.filteredList;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text('Menampilkan ${list.length} mahasiswa', style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      if (stateData.query.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {
                            _searchController.clear();
                            ref.read(mahasiswaAktifNotifierProvider.notifier).clearSearch();
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Bersihkan'),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: MahasiswaAktifListView(
                    list: list,
                    onRefresh: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Cari nama atau NIM...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            ref.read(mahasiswaAktifNotifierProvider.notifier).clearSearch();
          },
        ),
        filled: true,
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      onChanged: (v) => ref.read(mahasiswaAktifNotifierProvider.notifier).setSearchQuery(v),
      onSubmitted: (v) => ref.read(mahasiswaAktifNotifierProvider.notifier).setSearchQuery(v),
    );
  }
}