var sampleData = [
  {
    "id": "tfios",
    "title": "The Fault in Our Stars",
    "author": "John Green",
    "yearPublished": "2012",
    "synopsis":
        "The Fault in Our Stars follows the story of Hazel Grace Lancaster, a sixteen-year-old cancer patient who falls in love with Augustus Waters, a similarly afflicted teen from her cancer support group.",
    "genre": ["Young Adult", "Romance", "Contemporary"],
    "otherDetails": "New York Times Bestseller",
    "bookCover": "https://example.com/tfios_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "papertowns",
    "title": "Paper Towns",
    "author": "John Green",
    "yearPublished": "2008",
    "synopsis":
        "Paper Towns is a coming-of-age story centered around Quentin Jacobsen and his enigmatic neighbor Margo Roth Spiegelman. When Margo disappears after enlisting Quentin's help in an all-night revenge spree, Quentin embarks on a journey to find her.",
    "genre": ["Young Adult", "Mystery", "Contemporary"],
    "otherDetails": "Edgar Award for Best Young Adult Novel (2009)",
    "bookCover": "https://example.com/papertowns_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "lookingforalaska",
    "title": "Looking for Alaska",
    "author": "John Green",
    "yearPublished": "2005",
    "synopsis":
        "Looking for Alaska tells the story of Miles Halter, who leaves his home in Florida to attend Culver Creek Preparatory School in Alabama. There, he meets Alaska Young, a fascinating and enigmatic girl who changes his life forever.",
    "genre": ["Young Adult", "Contemporary", "Coming-of-Age"],
    "otherDetails": "Printz Award winner (2006)",
    "bookCover": "https://example.com/lookingforalaska_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "anabundanceofkatherines",
    "title": "An Abundance of Katherines",
    "author": "John Green",
    "yearPublished": "2006",
    "synopsis":
        "An Abundance of Katherines follows the story of child prodigy Colin Singleton, who embarks on a road trip with his friend Hassan after being dumped by his 19th Katherine. In an attempt to prove a mathematical theorem that will predict the outcome of romantic relationships, Colin finds unexpected friendships and self-discovery along the way.",
    "genre": ["Young Adult", "Contemporary", "Humor"],
    "otherDetails": "",
    "bookCover": "https://example.com/anabundanceofkatherines_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "willgraysonwillgrayson",
    "title": "Will Grayson, Will Grayson",
    "author": "John Green & David Levithan",
    "yearPublished": "2010",
    "synopsis":
        "Will Grayson, Will Grayson tells the story of two boys, both named Will Grayson, whose lives intersect unexpectedly in Chicago. One Will is gay and struggling with his identity, while the other struggles with friendship and love.",
    "genre": ["Young Adult", "Contemporary", "LGBTQ+"],
    "otherDetails": "",
    "bookCover": "https://example.com/willgraysonwillgrayson_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "turtlesallthewaydown",
    "title": "Turtles All the Way Down",
    "author": "John Green",
    "yearPublished": "2017",
    "synopsis":
        "Turtles All the Way Down follows the story of Aza Holmes, a sixteen-year-old girl living with obsessive-compulsive disorder (OCD), as she investigates the disappearance of a fugitive billionaire while navigating friendship, love, and her own mental health struggles.",
    "genre": ["Young Adult", "Contemporary", "Mental Health"],
    "otherDetails": "",
    "bookCover": "https://example.com/turtlesallthewaydown_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter1",
    "title": "Harry Potter and the Philosopher's Stone",
    "author": "J.K. Rowling",
    "yearPublished": "1997",
    "synopsis":
        "Harry Potter and the Philosopher's Stone follows the story of a young wizard, Harry Potter, who discovers his magical heritage on his eleventh birthday when he receives a letter of acceptance to the Hogwarts School of Witchcraft and Wizardry.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "First book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter1_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter2",
    "title": "Harry Potter and the Chamber of Secrets",
    "author": "J.K. Rowling",
    "yearPublished": "1998",
    "synopsis":
        "Harry Potter and the Chamber of Secrets continues the story of Harry Potter's second year at Hogwarts School of Witchcraft and Wizardry, where mysterious happenings occur, including the appearance of a sinister message on the walls of the school.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "Second book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter2_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter3",
    "title": "Harry Potter and the Prisoner of Azkaban",
    "author": "J.K. Rowling",
    "yearPublished": "1999",
    "synopsis":
        "Harry Potter and the Prisoner of Azkaban follows Harry Potter's third year at Hogwarts School of Witchcraft and Wizardry, during which he learns about his godfather, Sirius Black, and encounters the dangerous Dementors.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "Third book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter3_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter4",
    "title": "Harry Potter and the Goblet of Fire",
    "author": "J.K. Rowling",
    "yearPublished": "2000",
    "synopsis":
        "Harry Potter and the Goblet of Fire follows Harry Potter's fourth year at Hogwarts School of Witchcraft and Wizardry, during which he is chosen by the Goblet of Fire to compete in the Triwizard Tournament.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "Fourth book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter4_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter5",
    "title": "Harry Potter and the Order of the Phoenix",
    "author": "J.K. Rowling",
    "yearPublished": "2003",
    "synopsis":
        "Harry Potter and the Order of the Phoenix follows Harry Potter's fifth year at Hogwarts School of Witchcraft and Wizardry, during which he forms Dumbledore's Army to oppose the tyranny of Dolores Umbridge and learns more about Lord Voldemort's plans.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "Fifth book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter5_cover.jpg",
    "isAvailable": true
  },
  {
    "id": "harrypotter6",
    "title": "Harry Potter and the Half-Blood Prince",
    "author": "J.K. Rowling",
    "yearPublished": "2005",
    "synopsis":
        "Harry Potter and the Half-Blood Prince follows Harry Potter's sixth year at Hogwarts School of Witchcraft and Wizardry, during which he learns more about Voldemort's past and searches for Horcruxes, while Dumbledore prepares him for the final battle.",
    "genre": ["Fantasy", "Young Adult", "Adventure"],
    "otherDetails": "Sixth book in the Harry Potter series",
    "bookCover": "https://example.com/harrypotter6_cover.jpg",
    "isAvailable": true
  }
];

var sampleCategoriesList = {
  "popular": [
    "75c6ab80-1fd6-1f84-a0f4-ddc7e48f142f",
    "7d865000-1fd6-1f84-a0f4-ddc7e48f142f",
    "7e1ee680-1fd6-1f84-a0f4-ddc7e48f142f",
    "7eb77d00-1fd6-1f84-a0f4-ddc7e48f142f",
    "75c6ab80-1fd6-1f84-a0f4-ddc7e48f142f"
  ],
  "new": [
    "7eb77d01-1fd6-1f84-a0f4-ddc7e48f142f",
    "7f501380-1fd6-1f84-a0f4-ddc7e48f142f",
    "7fe8aa00-1fd6-1f84-a0f4-ddc7e48f142f",
    "80814080-1fd6-1f84-a0f4-ddc7e48f142f",
    "7d865000-1fd6-1f84-a0f4-ddc7e48f142f"
  ],
  "featured": [
    "8119d700-1fd6-1f84-a0f4-ddc7e48f142f",
    "81b26d80-1fd6-1f84-a0f4-ddc7e48f142f",
    "7fe8aa01-1fd6-1f84-a0f4-ddc7e48f142f",
    "7e1ee680-1fd6-1f84-a0f4-ddc7e48f142f",
    "8119d700-1fd6-1f84-a0f4-ddc7e48f142f"
  ]
};
