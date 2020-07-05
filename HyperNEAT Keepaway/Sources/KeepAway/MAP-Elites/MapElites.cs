using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using csmatio.types;
using csmatio.io;
using MLApp;
using System.IO;

namespace Keepaway
{
    public class MapElites
    {
        // properties
        public EliteMap eliteMap;

        // methods

        public MapElites()
        {
            // initialise properties
            eliteMap = new EliteMap();
        }

        public void updateMap(List<NetworkGenome> genomes)
        {
            // loop through each genome in list and add to appropriate position in eliteMap.Map
            for (int i = 0; i < genomes.Count; i++)
            {
                // check where genome fits into map
                // double cycles = genomes[i].BehaviorType.bVector[0];
                double teamDispersion = genomes[i].BehaviorType.bVector[1];
                double no_passes = genomes[i].BehaviorType.bVector[2];
                double distfromcentre = genomes[i].BehaviorType.bVector[3];

                int[] position = new int[3]; // x,y,z position, eg 0,0,0 or 0,3,1 etc.
                position[0] = (int)(Math.Round(teamDispersion, 2) * 100);
                position[1] = (int)(Math.Round(no_passes, 2) * 100);
                position[2] = (int)(Math.Round(distfromcentre, 2) * 100);

                

                // check if genome is better
                bool isbetterGenome = eliteMap.compareGenome(genomes[i], position);

                if (isbetterGenome)
                {
                    eliteMap.updateMapElement(genomes[i], position);
                }
            }
        }
        
        public void writeToFile()
        {
            // Initialise stringbuilder
            var csvRealFitness = new StringBuilder();
            var csvFitness = new StringBuilder();
            int indFlatMap = -1;

            var newLine = string.Empty;

            foreach (NetworkGenome genome in this.eliteMap.flatMap)
            {
                indFlatMap = this.eliteMap.findMapElement(genome.EliteMapPosition);

                newLine = string.Format("{0},{1},{2},{3}",
                    genome.EliteMapPosition[0].ToString(), genome.EliteMapPosition[1].ToString(), genome.EliteMapPosition[2].ToString(),
                    this.eliteMap.flatMap[indFlatMap].RealFitness.ToString(System.Globalization.CultureInfo.InvariantCulture));
                csvRealFitness.AppendLine(newLine);

                newLine = string.Format("{0},{1},{2},{3}",
                    genome.EliteMapPosition[0].ToString(), genome.EliteMapPosition[1].ToString(), genome.EliteMapPosition[2].ToString(),
                    this.eliteMap.flatMap[indFlatMap].Fitness.ToString(System.Globalization.CultureInfo.InvariantCulture));
                csvFitness.AppendLine(newLine);
            }

            // Write out data
            string filePath = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\real_fitness_gen_" + Program.evo.Generation.ToString() + ".csv";
            File.WriteAllText(filePath, csvRealFitness.ToString());

            filePath = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness_gen_" + Program.evo.Generation.ToString() + ".csv";
            File.WriteAllText(filePath, csvFitness.ToString());
        }        
    }
}
