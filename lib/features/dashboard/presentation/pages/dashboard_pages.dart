import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/core/constants/app_constants.dart';
import 'package:cobadulu/core/widgets/common_widgets.dart';
import 'package:cobadulu/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:cobadulu/features/dashboard/presentation/widgets/dashboard_widgets.dart';
import 'package:cobadulu/features/mahasiswa/presentation/pages/mahasiswa_page.dart';
import 'package:cobadulu/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import 'package:cobadulu/features/dosen/presentation/pages/dosen_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  // helper: pilih icon berdasarkan title stat
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Mahasiswa Lulus':
        return Icons.workspace_premium_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    // kita hanya watch selectedStatIndexProvider supaya perubahan global ter-observe
    ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () {
            ref.read(dashboardNotifierProvider.notifier).refresh();
          },
        ),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              // invalidate provider agar data di-refresh
              ref.invalidate(dashboardNotifierProvider);
              // tunggu sedikit supaya indikator refresh terlihat
              await Future<void>.delayed(const Duration(milliseconds: 200));
            },
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withBlue(220),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dashboard',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Selamat datang!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Update: ${_formatDate(dashboardData.lastUpdate)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Stats section
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            final stat = dashboardData.stats[index];
                            final gradient = AppConstants.dashboardGradients[
                            index % AppConstants.dashboardGradients.length];

                            return ModernStatCard(
                              stats: stat,
                              icon: _getIconForStat(stat.title),
                              gradientColors: gradient,
                              onTap: () {
                                // set selected index
                                ref.read(selectedStatIndexProvider.notifier).state = index;

                                final statTitle = stat.title;
                                Widget? targetPage;

                                switch (statTitle) {
                                  case 'Dosen':
                                    targetPage = const DosenPage();
                                    break;
                                  case 'Mahasiswa':
                                    targetPage = const MahasiswaPage();
                                    break;
                                  case 'Mahasiswa Aktif':
                                    targetPage = const MahasiswaAktifPage();
                                    break;
                                  case 'Mahasiswa Lulus':
                                  // belum ada halaman untuk Mahasiswa Lulus
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('$statTitle: Halaman belum tersedia.')),
                                    );
                                    break;
                                  default:
                                  // fallback: tidak melakukan apa-apa
                                    break;
                                }

                                if (targetPage != null) {
                                  Navigator.push(context, _createRoute(targetPage));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  // custom slide route
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // format tanggal
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}