import 'package:e_learning_dathboard/admin_screens/admin_home/widget/admin_home_item.dart';
import 'package:e_learning_dathboard/admin_screens/all_users/all_users.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/books_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/manage_certificate_screen.dart';
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/free_note_screen.dart';
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/group_info_screen.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/placements_screen.dart';
import 'package:e_learning_dathboard/admin_screens/reviews/screens/review_screen.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart'; // أيقونات أنيقة

import '../../business_logic/app_cubit/app_cubit.dart';
import '../../business_logic/app_cubit/app_states.dart';
import '../payment_screens/payment_requests_screen.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Manage Users",
        "icon": LucideIcons.userX,
        "color": Colors.redAccent,
        "onTap": () => navigateTo(context, const AllUser(verified: false)),
      },
      {
        "title": "Student Requests",
        "icon": LucideIcons.userCheck,
        "color": Colors.green,
        "onTap": () => navigateTo(context, const AllUser(verified: true)),
      },
      {
        "title": "Books & Handouts",
        "icon": LucideIcons.bookOpen,
        "color": Colors.blue,
        "onTap": () => navigateTo(context, const BooksAndHandoutsScreen()),
      },
      {
        "title": "Free Notes",
        "icon": LucideIcons.fileText,
        "color": Colors.teal,
        "onTap": () => navigateTo(context, const FreeNoteScreen()),
      },
      {
        "title": "Groups Info",
        "icon": LucideIcons.users,
        "color": Colors.orange,
        "onTap": () => navigateTo(context, GroupInfoScreen()),
      },
      {
        "title": "Placement Tests",
        "icon": LucideIcons.edit3,
        "color": Colors.indigo,
        "onTap": () => navigateTo(context, PlacementsScreen()),
      },
      {
        "title": "Payment Requests",
        "icon": LucideIcons.creditCard,
        "color": Colors.purple,
        "onTap": () => navigateTo(context, const PaymentRequestsScreen()),
      },
      {
        "title": "Certificates",
        "icon": LucideIcons.award,
        "color": Colors.cyan,
        "onTap": () => navigateTo(context, const ManageCertificateScreen()),
      },
      {
        "title": "Reviews",
        "icon": LucideIcons.star,
        "color": Colors.amber,
        "onTap": () => navigateTo(context, const ReviewScreen()),
      },
    ];

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorManager.primary, ColorManager.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                'Admin Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * .025,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: item["onTap"] as VoidCallback,
                    leading: CircleAvatar(
                      backgroundColor: (item["color"] as Color).withOpacity(0.2),
                      child: Icon(item["icon"] as IconData,
                          color: item["color"] as Color, size: 22),
                    ),
                    title: Text(
                      item["title"] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: items.length,
            ),
          ),
        );
      },
    );
  }
}
