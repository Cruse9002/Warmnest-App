import 'package:flutter/material.dart';

class BreathingExercisesScreen extends StatelessWidget {
  const BreathingExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guided Breathing Exercises',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find calm and focus with these simple breathing techniques.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              mainAxisSpacing: 20,
              childAspectRatio: 2.2,
              children: [
                _buildBreathingCard(
                  context,
                  'Box Breathing',
                  'A simple technique to calm your nerves by inhaling, holding, exhaling, and holding for equal durations.',
                  '5 min',
                  'https://pixabay.com/get/g841edb0bc26b0e8a133ca4a51da446e877049f4ede8e1f0d2ea9a47083773f1f300bbe16a7a0b31b5a6546bf1e561345ed29dd424b634e6c87e9fcee5a3226ec_1280.jpg',
                ),
                _buildBreathingCard(
                  context,
                  '4-7-8 Breathing',
                  'A relaxing breath technique: inhale for 4, hold for 7, exhale for 8. Helps with sleep and anxiety.',
                  '3 min',
                  'https://pixabay.com/get/g1d3bf4786aeed55097b7df8495813fb903468d7a53eabb689bf30321e0e43e9cd3afc166435296a5b433081a313a03990cd20597178174b0bffe808f092a6c2e_1280.png',
                ),
                _buildBreathingCard(
                  context,
                  'Diaphragmatic Breathing (Belly Breathing)',
                  'Focus on deep belly breaths to fully engage the diaphragm, promoting relaxation and efficient breathing.',
                  '7 min',
                  'https://pixabay.com/get/g2487c0d7a84c42714b19a260021ac2190224f7d5ee83fc3f49d6019ce53aba480f149995e42303371537cbc934e4279e696e0d3e310210787010411a2ead88f7_1280.jpg',
                ),
              ],
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.8,
              children: [
                _buildTechniqueCard(
                  context,
                  'Mindful Breathing',
                  'Simple awareness of breath',
                  '4 min',
                ),
                _buildTechniqueCard(
                  context,
                  'Ocean Breathing',
                  'Breathe like ocean waves',
                  '6 min',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreathingCard(
    BuildContext context,
    String title,
    String description,
    String duration,
    String imageUrl,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF4A9EFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF9CA3AF),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: Color(0xFF9CA3AF), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9EFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Start Exercise',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechniqueCard(
    BuildContext context,
    String title,
    String description,
    String duration,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.schedule, color: Color(0xFF9CA3AF), size: 14),
              const SizedBox(width: 4),
              Text(
                duration,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}