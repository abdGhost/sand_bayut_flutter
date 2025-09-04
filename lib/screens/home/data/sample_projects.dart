class Project {
  final String title;
  final String location;
  final String image;
  final String handover; // Q3 2026
  final String launchPrice; // AED 1.1M
  const Project({
    required this.title,
    required this.location,
    required this.image,
    required this.handover,
    required this.launchPrice,
  });
}

const sampleProjects = <Project>[
  Project(
    title: 'Alta by Meteora',
    location: 'JVC District 11, Jumeirah Village Circle',
    image:
        'https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1200&auto=format&fit=crop',
    handover: 'Q3 2026',
    launchPrice: 'AED 1.1M',
  ),
  Project(
    title: 'Lakeshore Vista',
    location: 'The Lagoons, Dubai Creek Harbour',
    image:
        'https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1200&auto=format&fit=crop',
    handover: 'Q1 2027',
    launchPrice: 'AED 1.6M',
  ),
];
