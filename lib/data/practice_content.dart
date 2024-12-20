class PracticeContent {
  static const Map<String, List<Map<String, dynamic>>> mathContent = {
    'Algebra': [
      {
        'topic': 'Linear Equations',
        'questions': [
          {
            'question': 'Solve for x: 2x + 5 = 13',
            'options': ['x = 4', 'x = 6', 'x = 8', 'x = 3'],
            'correct': 0,
            'explanation': 'Subtract 5 from both sides: 2x = 8\nDivide both sides by 2: x = 4',
          },
          {
            'question': 'If 3(x - 2) = 15, what is x?',
            'options': ['x = 7', 'x = 5', 'x = 9', 'x = 3'],
            'correct': 1,
            'explanation': 'Distribute 3: 3x - 6 = 15\nAdd 6 to both sides: 3x = 21\nDivide by 3: x = 7',
          },
        ],
        'practice_problems': [
          'Solve: 5x - 3 = 12',
          'Solve: 2(x + 4) = 16',
          'Solve: 4x + 7 = 3x - 2',
        ],
      },
    ],
    'Geometry': [
      {
        'topic': 'Triangles',
        'questions': [
          {
            'question': 'What is the sum of angles in a triangle?',
            'options': ['180°', '360°', '90°', '270°'],
            'correct': 0,
            'explanation': 'The sum of angles in a triangle is always 180 degrees.',
          },
          {
            'question': 'In a right triangle, one angle is 90° and another is 30°. What is the third angle?',
            'options': ['30°', '45°', '60°', '90°'],
            'correct': 2,
            'explanation': '90° + 30° + x = 180°\n120° + x = 180°\nx = 60°',
          },
        ],
        'practice_problems': [
          'Find the area of a triangle with base 6cm and height 8cm',
          'Calculate the perimeter of a triangle with sides 3cm, 4cm, and 5cm',
          'Find the missing angle in a triangle with angles 45° and 60°',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> englishContent = {
    'Grammar': [
      {
        'topic': 'Parts of Speech',
        'questions': [
          {
            'question': 'Which word in the sentence is a verb: "The cat sleeps on the mat"?',
            'options': ['cat', 'sleeps', 'on', 'mat'],
            'correct': 1,
            'explanation': '"Sleeps" is the verb as it shows the action in the sentence.',
          },
          {
            'question': 'Identify the adjective: "The red car is fast"',
            'options': ['the', 'red', 'car', 'fast'],
            'correct': 1,
            'explanation': '"Red" is an adjective as it describes the car.',
          },
        ],
        'practice_problems': [
          'Identify all parts of speech in: "The happy dog quickly chased the ball"',
          'Write sentences using different parts of speech',
          'Convert nouns to adjectives',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> geographyContent = {
    'Physical Geography': [
      {
        'topic': 'Ethiopian Landscapes',
        'questions': [
          {
            'question': 'What is the highest mountain in Ethiopia?',
            'options': ['Ras Dashen', 'Mount Batu', 'Mount Abuna Yosef', 'Mount Guna'],
            'correct': 0,
            'explanation': 'Ras Dashen, at 4,550 meters, is the highest mountain in Ethiopia.',
          },
          {
            'question': 'Which rift valley lake is the largest in Ethiopia?',
            'options': ['Lake Tana', 'Lake Abaya', 'Lake Chamo', 'Lake Ziway'],
            'correct': 1,
            'explanation': 'Lake Abaya is the largest rift valley lake in Ethiopia.',
          },
        ],
        'practice_problems': [
          'Label major rivers on a map of Ethiopia',
          'Describe the climate zones of Ethiopia',
          'Identify major mountain ranges',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> historyContent = {
    'Ethiopian History': [
      {
        'topic': 'Ancient Civilizations',
        'questions': [
          {
            'question': 'Which ancient kingdom was known for its obelisks?',
            'options': ['Axum', 'Lalibela', 'Gondar', 'Harar'],
            'correct': 0,
            'explanation': 'The Kingdom of Axum was famous for its obelisks (stelae).',
          },
          {
            'question': 'When was the Battle of Adwa fought?',
            'options': ['1896', '1889', '1887', '1900'],
            'correct': 0,
            'explanation': 'The Battle of Adwa was fought in 1896, resulting in Ethiopian victory over Italy.',
          },
        ],
        'practice_problems': [
          'Create a timeline of Ethiopian dynasties',
          'Write about the significance of Lalibela churches',
          'Describe the reign of Emperor Menelik II',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> socialStudiesContent = {
    'Civics': [
      {
        'topic': 'Ethiopian Constitution',
        'questions': [
          {
            'question': 'When was the current Ethiopian Constitution adopted?',
            'options': ['1995', '1991', '1993', '1997'],
            'correct': 0,
            'explanation': 'The current Ethiopian Constitution was adopted in 1995.',
          },
          {
            'question': 'How many regional states are there in Ethiopia?',
            'options': ['9', '10', '11', '12'],
            'correct': 2,
            'explanation': 'Ethiopia has 11 regional states according to the current structure.',
          },
        ],
        'practice_problems': [
          'List the fundamental rights in the Constitution',
          'Explain the federal system of Ethiopia',
          'Describe the role of the House of Peoples Representatives',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> biologyContent = {
    'Human Biology': [
      {
        'topic': 'Digestive System',
        'questions': [
          {
            'question': 'What is the function of the small intestine?',
            'options': [
              'Nutrient absorption',
              'Water absorption',
              'Food storage',
              'Bile production'
            ],
            'correct': 0,
            'explanation': 'The small intestine is primarily responsible for nutrient absorption.',
          },
          {
            'question': 'Which organ produces insulin?',
            'options': ['Liver', 'Pancreas', 'Stomach', 'Gallbladder'],
            'correct': 1,
            'explanation': 'The pancreas produces insulin to regulate blood sugar levels.',
          },
        ],
        'practice_problems': [
          'Label the parts of the digestive system',
          'Explain the process of digestion',
          'Describe the role of enzymes in digestion',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> physicsContent = {
    'Mechanics': [
      {
        'topic': 'Forces and Motion',
        'questions': [
          {
            'question': 'What is Newton\'s First Law of Motion?',
            'options': [
              'An object at rest stays at rest unless acted upon by a force',
              'Force equals mass times acceleration',
              'Every action has an equal and opposite reaction',
              'None of the above'
            ],
            'correct': 0,
            'explanation': 'Newton\'s First Law states that an object will remain at rest or in uniform motion unless acted upon by an external force.',
          },
          {
            'question': 'Calculate the force needed to accelerate a 2kg mass at 3 m/s²',
            'options': ['2 N', '4 N', '6 N', '8 N'],
            'correct': 2,
            'explanation': 'F = ma\nF = 2kg × 3m/s²\nF = 6N',
          },
        ],
        'practice_problems': [
          'Calculate acceleration using F = ma',
          'Solve problems involving friction',
          'Analyze forces in equilibrium',
        ],
      },
    ],
  };

  static const Map<String, List<Map<String, dynamic>>> chemistryContent = {
    'Matter': [
      {
        'topic': 'Chemical Reactions',
        'questions': [
          {
            'question': 'What type of reaction occurs when two substances combine to form a new substance?',
            'options': ['Synthesis', 'Decomposition', 'Single replacement', 'Double replacement'],
            'correct': 0,
            'explanation': 'A synthesis reaction is when two or more substances combine to form a new compound.',
          },
          {
            'question': 'Balance this equation: H₂ + O₂ → H₂O',
            'options': ['2H₂ + O₂ → 2H₂O', 'H₂ + O₂ → H₂O', 'H₂ + 2O₂ → H₂O', 'None of the above'],
            'correct': 0,
            'explanation': 'The balanced equation is 2H₂ + O₂ → 2H₂O to have equal numbers of each atom on both sides.',
          },
        ],
        'practice_problems': [
          'Balance chemical equations',
          'Identify types of reactions',
          'Calculate molecular mass',
        ],
      },
    ],
  };
}
