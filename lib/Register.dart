import 'package:cyberguard/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
final baseurl='http://192.168.1.111:5000';
Dio dio= Dio();

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {

  /// 🔹 FORM KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// 🔹 CONTROLLERS (EACH FIELD)
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// 🔹 FOCUS NODES
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  bool _agree = false;
  bool _showPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    for (final n in _focusNodes) n.dispose();
    super.dispose();
  }

Future<void> post_reg(content) async {
  try {
    final response = await dio.post(
    '$baseurl/userregister',
    data:{
      'Name' : fullNameController.text,
      'Emailid' :emailController.text,
      'PhoneNumber': phoneController.text,
      'username' :emailController.text,
      'password' :passwordController.text,
    }
    );
     
    print(response.data);

    if(response.statusCode==200|| response.statusCode==201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> LoginPage())
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
    } else{
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration  failed'))
      );
    }
    
  } catch (e) {
    print("Registration error: $e");
  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: Container(
          width: 440,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),

          /// 🔹 FORM WRAPPER
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(Icons.shield_outlined, color: Color(0xFF4C6FFF)),
                    SizedBox(width: 8),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1F36),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Your data is protected with secure encryption",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 36),

                _animatedField(
                  "Full Name",
                  fullNameController,
                  _focusNodes[0],
                  Icons.person_outline,
                  validator: (v) =>
                      v!.isEmpty ? "Full Name is required" : null,
                ),

                _animatedField(
                  "Email Address",
                  emailController,
                  _focusNodes[1],
                  Icons.email_outlined,
                  validator: (v) {
                    if (v!.isEmpty) return "Email is required";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),

                _animatedField(
                  "Country",
                  countryController,
                  _focusNodes[2],
                  Icons.public,
                  validator: (v) =>
                      v!.isEmpty ? "Country is required" : null,
                ),

                _animatedField(
                  "Phone Number",
                  phoneController,
                  _focusNodes[3],
                  Icons.phone_outlined,
                  validator: (v) {
                    if (v!.isEmpty) return "Phone number is required";
                    if (v.length < 10) return "Enter valid phone number";
                    return null;
                  },
                ),

                _animatedField(
                  "Password",
                  passwordController,
                  _focusNodes[4],
                  Icons.lock_outline,
                  isPassword: true,
                  validator: (v) {
                    if (v!.isEmpty) return "Password is required";
                    if (v.length < 6) return "Min 6 characters required";
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      activeColor: const Color(0xFF4C6FFF),
                      onChanged: (v) => setState(() => _agree = v!),
                    ),
                    const Expanded(
                      child: Text(
                        "I agree to the Terms & Privacy Policy",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 ANIMATED TEXTFORMFIELD
  Widget _animatedField(
    String label,
    TextEditingController controller,
    FocusNode focusNode,
    IconData icon, {
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: AnimatedBuilder(
        animation: Listenable.merge([focusNode, controller]),
        builder: (_, __) {
          final focused = focusNode.hasFocus;
          final filled = controller.text.isNotEmpty;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: focused
                    ? const Color(0xFF4C6FFF)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword && !_showPassword,
              validator: validator,
              decoration: InputDecoration(
                hintText: label,
                errorStyle: const TextStyle(fontSize: 11),
                prefixIcon: Icon(
                  icon,
                  color:
                      focused ? const Color(0xFF4C6FFF) : Colors.grey,
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      )
                    : AnimatedScale(
                        scale: filled ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.check_circle,
                            color: Color(0xFF00D68F)),
                      ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 18),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 SUBMIT BUTTON WITH FORM VALIDATION
  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: !_agree || _isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                setState(() => _isLoading = true);
                await Future.delayed(const Duration(seconds: 2));
                post_reg(context);
                setState(() => _isLoading = false);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account Created Successfully"),
                  ),
                );
              }
            },
      child: AnimatedOpacity(
        opacity: _agree ? 1 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4C6FFF), Color(0xFF00E5FF)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
