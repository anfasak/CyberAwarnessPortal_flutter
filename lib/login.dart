import 'package:cyberguard/BottomBar.dart';
import 'package:cyberguard/Register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
int? loginid;

class _LoginPageState extends State<LoginPage> {
  // Controllers & state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  // Theme colors (cyber)
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color cardDark = Color(0xFF1A1F25);
  static const Color neon = Color(0xFF00E5FF);

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _tryLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    // Simulate a short delay (UI only, no backend)
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in (UI demo)'), behavior: SnackBarBehavior.floating),
      );
    });
  }

  Future<void> post_login(content) async {
  try {
    final response = await dio.post(
    '$baseurl/LoginAPI',
    data:{
      'username' :_userCtrl.text,
      'password' :_passCtrl.text,
    }
    );
     
    print(response.data);

    if(response.statusCode==200|| response.statusCode==201) {
loginid=response.data['username'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>BottomBarPage())
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
    } else{
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login failed'))
      );
    }
    
  } catch (e) {
    print("Login error: $e");
  }

}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width >= 900 ? 520.0 : (width * 0.92);

    return Scaffold(
      backgroundColor: backgroundDark,
      // Modern transparent appbar with neon badge
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 78,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [neon, Color(0xFF36D8FF)]),
              boxShadow: [BoxShadow(color: neon.withOpacity(0.6), blurRadius: 10, spreadRadius: 1)],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Welcome to CyberGuard',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 0.4),
          ),
        ]),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Column(
            children: [
              // Optional header / illustration area
              SizedBox(
                width: cardWidth,
                child: Column(
                  children: const [
                    SizedBox(height: 6),
                    Text(
                      'Welcome Back',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Sign in to continue to the Cyber Awareness Game',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 18),
                  ],
                ),
              ),

              // Card container
              Container(
                width: cardWidth,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F151A), cardDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: neon.withOpacity(0.10)),
                  boxShadow: [
                    BoxShadow(color: neon.withOpacity(0.06), blurRadius: 28, spreadRadius: 2, offset: const Offset(0, 12)),
                    BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 6, offset: const Offset(0, 4)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username field
                      _buildField(
                        controller: _userCtrl,
                        label: 'Username',
                        hint: 'Enter username',
                        icon: Icons.person_outline,
                        validator: (s) => s == null || s.trim().isEmpty ? 'Please enter username' : null,
                      ),

                      const SizedBox(height: 14),

                      // Password field
                      _buildField(
                        controller: _passCtrl,
                        label: 'Password',
                        hint: 'Enter password',
                        icon: Icons.lock_outline,
                        obscure: _obscure,
                        suffix: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: neon),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        validator: (s) => s == null || s.length < 4 ? 'Password must be 4+ chars' : null,
                      ),

                      const SizedBox(height: 18),

                      // Forgot + remember row
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // UI-only placeholder
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Forgot password tapped')));
                              },
                              child: const Text('Forgot password?', style: TextStyle(color: Colors.white70, fontSize: 13)),
                            ),
                          ),
                          // small "Remember me" placeholder
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: Checkbox(
                                  value: true,
                                  onChanged: (_) {},
                                  activeColor: neon,
                                  checkColor: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('Remember', style: TextStyle(color: Colors.white70, fontSize: 13)),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Submit button (neon gradient)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){post_login(context);},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [neon, Color(0xFF36D8FF)]),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: neon.withOpacity(0.28), blurRadius: 18, spreadRadius: 1)],
                            ),
                            child: Center(
                              child: _loading
                                  ? const CircularProgressIndicator(color: Colors.black)
                                  : const Text('LOGIN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Or sign in with
                      Row(
                        children: const [
                          Expanded(child: Divider(color: Colors.white12)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Or continue with', style: TextStyle(color: Colors.white38, fontSize: 12)),
                          ),
                          Expanded(child: Divider(color: Colors.white12)),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Social / quick login buttons (UI only)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: neon.withOpacity(0.14)),
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              icon: Icon(Icons.fingerprint, color: neon),
                              label: const Text('Biometric', style: TextStyle(color: Colors.white70)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: neon.withOpacity(0.14)),
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              icon: Icon(Icons.g_mobiledata, color: neon),
                              label: const Text('Google', style: TextStyle(color: Colors.white70)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Footer: register hint
              SizedBox(
                width: cardWidth,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.white70)),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Register tapped (UI only)')));
                    },
                    child: Text('Create account', style: TextStyle(color: neon, fontWeight: FontWeight.bold)),
                  ),
                ]),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable input field builder with neon focus effect
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    Widget? suffix,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Focus(
      child: Builder(builder: (context) {
        final hasFocus = Focus.of(context).hasPrimaryFocus;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F1419),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: hasFocus ? neon.withOpacity(0.92) : neon.withOpacity(0.08), width: hasFocus ? 1.6 : 1.0),
            boxShadow: hasFocus ? [BoxShadow(color: neon.withOpacity(0.08), blurRadius: 14, spreadRadius: 1)] : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            cursorColor: neon,
            decoration: InputDecoration(
              icon: icon != null ? Icon(icon, color: Colors.white70) : null,
              border: InputBorder.none,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white24),
              suffixIcon: suffix,
            ),
            validator: validator,
          ),
        );
      }),
    );
  }
}
