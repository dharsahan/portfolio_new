import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_colors.dart';

class LeetCodeView extends StatefulWidget {
  const LeetCodeView({super.key});

  @override
  State<LeetCodeView> createState() => _LeetCodeViewState();
}

class _LeetCodeViewState extends State<LeetCodeView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  
  bool _isLoading = true;
  Map<String, dynamic> _stats = {};
  List<dynamic> _recentActivities = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    _fetchLeetCodeData();
  }

  Future<void> _fetchLeetCodeData() async {
    try {
      final statsResponse = await http.get(
        Uri.parse('https://leetcode-stats-api.herokuapp.com/dharshanbalaji83'),
      );
      
      final activityResponse = await http.get(
        Uri.parse('https://alfa-leetcode-api.onrender.com/dharshanbalaji83/acSubmission'),
      );

      if (statsResponse.statusCode == 200 && activityResponse.statusCode == 200) {
        if (mounted) {
          setState(() {
            _stats = json.decode(statsResponse.body);
            final activityData = json.decode(activityResponse.body);
            _recentActivities = activityData['submission'] ?? [];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching LeetCode data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 800 ? size.width * 0.1 : 20,
        vertical: 80,
      ),
      child: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
          : Column(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Text(
                  "Coding Journey",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 4,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "LeetCode ID: dharshanbalaji83",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildStatsCard()),
                    const SizedBox(width: 40),
                    Expanded(child: _buildRecentActivity()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildStatsCard(),
                    const SizedBox(height: 40),
                    _buildRecentActivity(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Problem Solving Stats",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 10,
            runSpacing: 20,
            children: [
              _buildCircularIndicator("Easy", _stats['easySolved'] ?? 0, _stats['totalEasy'] ?? 1, Colors.teal),
              _buildCircularIndicator("Medium", _stats['mediumSolved'] ?? 0, _stats['totalMedium'] ?? 1, Colors.orange),
              _buildCircularIndicator("Hard", _stats['hardSolved'] ?? 0, _stats['totalHard'] ?? 1, Colors.red),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          _buildTotalSolved(),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(String label, int solved, int total, Color color) {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: solved / total),
          duration: const Duration(seconds: 2),
          builder: (context, double value, child) {
            return SizedBox(
              height: 85,
              width: 85,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 85,
                      width: 85,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[200],
                        color: color,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$solved",
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "/$total",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSolved() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Solved",
                style: TextStyle(color: AppColors.secondaryColor, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                "${_stats['totalSolved'] ?? 0}",
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.orange),
          ),
          child: Text(
            "Rank: ${_stats['ranking'] ?? 'N/A'}",
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Activity",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (_recentActivities.isEmpty)
            const Text("No recent activity found.")
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentActivities.length > 5 ? 5 : _recentActivities.length,
              itemBuilder: (context, index) {
                final activity = _recentActivities[index];
                return _buildActivityItem(activity, index);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, int index) {
    Color statusColor = activity['statusDisplay'] == 'Accepted' ? Colors.teal : Colors.red;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 200)),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      activity['statusDisplay'] == 'Accepted' ? Icons.check : Icons.close,
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'],
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${activity['lang']} • ${_getTimeAgo(activity['timestamp'])}",
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTimeAgo(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
