import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:scam_wise_/mongo_connection/mongo_DB_report.dart';

class ReportScamPage extends StatefulWidget {
  const ReportScamPage({super.key});

  @override
  State<ReportScamPage> createState() => _ReportScamPageState();
}

class _ReportScamPageState extends State<ReportScamPage> {
  String? _pickedFile;
  String? _selectedCategory;

  final List<String> _scamCategories = [
    'Phishing',
    'Fake Job',
    'Online Shopping Fraud',
    'Lottery Scam',
    'Impersonation',
    'Others',
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _pickedFile = result.files.single.name;
      });
    }
  }

  void _submitReport() async {
    if (_pickedFile != null && _selectedCategory != null) {
      //prepare to send data
      final report = {
        "catergory": _selectedCategory,
        "filename": _pickedFile,
        "timestamp": DateTime.now().toIso8601String(),
      };
      try {
        await MongoDbReport.insertReport(report);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Scam reported Succesfully"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to report scam : $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a file and a scam category."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report a Scam"),
        backgroundColor: const Color.fromARGB(255, 24, 102, 116),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(
                  color: Colors.teal,
                  style: BorderStyle.solid,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: _pickFile,
                child: Center(
                  child: _pickedFile == null
                      ? const Text(
                          "Drop a file here to upload, or\nclick here to browse",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blueGrey),
                        )
                      : Text(
                          _pickedFile!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Dropdown label
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Colors.black,
              child: const Center(
                child: Text(
                  'What is the category of scam',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select any from drop down'),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: _scamCategories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),

            const Spacer(),

            // Report button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Report",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
