import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  bool isEditing = false;

  // ✅ user data (from signup/firebase)
  String name = "—";
  String company = "—";
  String phone = "—";
  String role = "—";

  // ✅ editable fields
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController panCtrl = TextEditingController();

  String language = "en";

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => isLoading = true);

    // TODO: Replace with Firestore fetch
    await Future.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;

    setState(() {
      name = "Rajesh Sharma";
      company = "Sharma Constructions";
      phone = "+91 98765 43210";
      role = "Owner";

      emailCtrl.text = "";
      addressCtrl.text = "";
      panCtrl.text = "";

      isLoading = false;
    });
  }

  void _toggleEdit() {
    setState(() => isEditing = !isEditing);
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();

    // TODO: Save to Firestore
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() => isEditing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Profile saved")),
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    addressCtrl.dispose();
    panCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Material wrapper fixes bottomsheet "No Material widget found"
    return Material(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  children: [
                    // ✅ handle bar (nice for bottomsheet)
                    Center(
                      child: Container(
                        width: 60,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),

                    // ✅ Profile Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ PROFILE + Edit Button
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "PROFILE",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.4,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: _toggleEdit,
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isEditing
                                            ? Icons.check_circle_outline_rounded
                                            : Icons.edit_note_rounded,
                                        size: 22,
                                        color: const Color(0xFF2563EB),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isEditing ? "Done" : "Edit",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF2563EB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // ✅ Signup details
                          _InfoTile(
                            icon: Icons.person_rounded,
                            label: "Name",
                            value: name,
                          ),
                          const SizedBox(height: 12),
                          _InfoTile(
                            icon: Icons.business_rounded,
                            label: "Company",
                            value: company,
                          ),
                          const SizedBox(height: 12),
                          _InfoTile(
                            icon: Icons.phone_rounded,
                            label: "Phone",
                            value: phone,
                          ),
                          const SizedBox(height: 12),
                          _InfoTile(
                            icon: Icons.verified_user_rounded,
                            label: "Role",
                            value: role,
                          ),

                          const SizedBox(height: 20),
                          const Divider(height: 1),
                          const SizedBox(height: 18),

                          const Text(
                            "ADD MORE DETAILS",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 12),

                          _EditField(
                            enabled: isEditing,
                            controller: emailCtrl,
                            label: "Email",
                            hint: "Enter email address",
                            icon: Icons.email_rounded,
                          ),
                          const SizedBox(height: 12),
                          _EditField(
                            enabled: isEditing,
                            controller: addressCtrl,
                            label: "Address",
                            hint: "Enter your address",
                            icon: Icons.location_on_rounded,
                          ),
                          const SizedBox(height: 12),
                          _EditField(
                            enabled: isEditing,
                            controller: panCtrl,
                            label: "PAN / GST (optional)",
                            hint: "Enter PAN or GST number",
                            icon: Icons.badge_rounded,
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "LANGUAGE PREFERENCE",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 10),

                          IgnorePointer(
                            ignoring: !isEditing,
                            child: Opacity(
                              opacity: isEditing ? 1 : 0.6,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: language,
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    items: const [
                                      DropdownMenuItem(
                                          value: "en",
                                          child: Text("English")),
                                      DropdownMenuItem(
                                          value: "hi", child: Text("हिंदी")),
                                      DropdownMenuItem(
                                          value: "mr", child: Text("मराठी")),
                                    ],
                                    onChanged: (val) {
                                      if (val == null) return;
                                      setState(() => language = val);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),
                          const Text(
                            "App language will update based on your preference",
                            style: TextStyle(fontSize: 11, color: Colors.black45),
                          ),

                          const SizedBox(height: 22),

                          // ✅ Save only when editing
                          if (isEditing)
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton.icon(
                                onPressed: _saveProfile,
                                icon: const Icon(Icons.save_rounded),
                                label: const Text(
                                  "SAVE",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0F172A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
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
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black45),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  const _EditField({
    required this.enabled,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.black45),
            ),
          ),
        ),
      ],
    );
  }
}
