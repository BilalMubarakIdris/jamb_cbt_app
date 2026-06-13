class SubjectCombination {
  final String title;
  final List<String> subjects; // Always includes English first

  SubjectCombination({required this.title, required this.subjects});
}

// Predefined combinations per PRD
final List<SubjectCombination> scienceCombinations = [
  SubjectCombination(
    title: 'Engineering',
    subjects: ['English', 'Mathematics', 'Physics', 'Chemistry'],
  ),
  SubjectCombination(
    title: 'Medicine',
    subjects: ['English', 'Biology', 'Chemistry', 'Physics'],
  ),
  SubjectCombination(
    title: 'Computer Science',
    subjects: ['English', 'Mathematics', 'Physics', 'Chemistry'],
  ),
  SubjectCombination(
    title: 'Pharmacy',
    subjects: ['English', 'Biology', 'Chemistry', 'Physics'],
  ),
  SubjectCombination(
    title: 'Biochemistry',
    subjects: ['English', 'Biology', 'Chemistry', 'Physics'],
  ),
  SubjectCombination(
    title: 'Industrial Chemistry',
    subjects: ['English', 'Mathematics', 'Chemistry', 'Physics'],
  ),
];
