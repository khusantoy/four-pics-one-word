class PuzzleRepo {
  List<Map<String, dynamic>> puzzles = [
    {
      "images": [
        'assets/images/cold1.jpg',
        'assets/images/cold2.jpg',
        'assets/images/cold3.jpg',
        'assets/images/cold4.jpg'
      ],
      "word": "cold"
    },
    {
      "images": [
        'assets/images/fire1.jpg',
        'assets/images/fire2.jpg',
        'assets/images/fire3.jpg',
        'assets/images/fire4.jpg'
      ],
      "word": "fire"
    },
    {
      "images": [
        'assets/images/run1.jpg',
        'assets/images/run2.jpg',
        'assets/images/run3.jpg',
        'assets/images/run4.jpg'
      ],
      "word": "run"
    },
    {
      "images": [
        'assets/images/think1.jpg',
        'assets/images/think2.gif',
        'assets/images/think3.jpg',
        'assets/images/think4.jpg'
      ],
      "word": "think"
    }
  ];

  List<Map<String, dynamic>> getPuzzles() {
    return puzzles;
  }
}
