import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sstfix/Onboarding%20Page/Genere%20selection/GenreSelection.dart';
import 'package:sstfix/Screens/Home/components/HomepageBody.dart';
import 'package:sstfix/Screens/auth_page.dart';

final authStream = StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final authData = ref.watch(authStream);
              return authData.when(
                  data: (data){
                    if(data == null){
                      return AuthPage();
                    }else{
                      return GenreSelection();
                    }
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator())
              );
            }
    )
    );
  }
}
