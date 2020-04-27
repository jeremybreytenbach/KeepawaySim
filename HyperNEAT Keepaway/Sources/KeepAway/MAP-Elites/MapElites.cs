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
                // round each dimension and normalise to fit in map (divide by FitNormaliser, which should usually by = 10)
                // subtract 1 to ???
                position[0] = (int)Math.Round(teamDispersion / Program.config.FitNormaliser) - 1;
                position[1] = (int)Math.Round(no_passes / Program.config.FitNormaliser) - 1;
                position[2] = (int)Math.Round(distfromcentre / Program.config.FitNormaliser) - 1;

                if (position[0] < 1)
                {
                    position[0] += 1;
                }
                if (position[1] < 1)
                {
                    position[1] += 1;
                }
                if (position[2] < 1)
                {
                    position[2] += 1;
                }

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

            //foreach (MapElement mapElement in this.eliteMap.Map)
            for (int z = 0; z < EliteMap.dimensionMax; z++)
            {
                for (int r = 0; r < EliteMap.dimensionMax; r++)
                {
                    for (int c = 0; c < EliteMap.dimensionMax; c++)
                    {
                        var newLine = string.Format("{0},{1},{2},{3}", r.ToString(), c.ToString(), z.ToString(), this.eliteMap.Map[r, c, z].realFitness.ToString(System.Globalization.CultureInfo.InvariantCulture));
                        csvRealFitness.AppendLine(newLine);

                        newLine = string.Format("{0},{1},{2},{3}", r.ToString(), c.ToString(), z.ToString(), this.eliteMap.Map[r, c, z].fitness.ToString(System.Globalization.CultureInfo.InvariantCulture));
                        csvFitness.AppendLine(newLine);
                    }
                }
            }

            // Write out data
            string filePath = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\real_fitness_gen_" + Program.evo.Generation.ToString() + ".csv";
            File.WriteAllText(filePath, csvRealFitness.ToString());

            filePath = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness_gen_" + Program.evo.Generation.ToString() + ".csv";
            File.WriteAllText(filePath, csvFitness.ToString());
        }

        public void writeToMatlabFile()
        {
            double[,] realFitness = new double[EliteMap.dimensionMax, EliteMap.dimensionMax];
            double[,] fitness = new double[EliteMap.dimensionMax, EliteMap.dimensionMax];

            // initialise matlab interface
            MLApp.MLApp matlab = new MLApp.MLApp();

            //foreach (MapElement mapElement in this.eliteMap.Map)
            for (int z = 0; z < EliteMap.dimensionMax; z++)
            {
                for (int r = 0; r < EliteMap.dimensionMax; r++)
                {
                    for (int c = 0; c < EliteMap.dimensionMax; c++)
                    {
                        realFitness[r, c] = this.eliteMap.Map[r, c, z].realFitness;
                        fitness[r, c] = this.eliteMap.Map[r, c, z].fitness;

                    }
                }
                // place each layer of fitness into matlab base workspace with a new name
                matlab.PutFullMatrix("fitness_" + z.ToString(), "base", fitness, fitness);
                matlab.PutFullMatrix("realFitness_" + z.ToString(), "base", realFitness, realFitness);
            }

            //matlab.Execute(@"for k = 0:99; save(sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness%i.mat',k),sprintf('fitness_%i',k)); end");

            matlab.Execute(@"for k = 0:99;fitness(1:100,1:100,k+1) =  eval(sprintf('fitness_%i',k));end");
            //matlab.Execute(@"save('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness.mat','fitness')");
            matlab.Execute(@"save('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness" + Program.evo.Generation.ToString() + ".mat','fitness')");


            matlab.Execute(@"for k = 0:99;realFitness(1:100,1:100,k+1) =  eval(sprintf('realFitness_%i',k));end");
            //matlab.Execute(@"save('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness.mat','fitness')");
            matlab.Execute(@"save('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\realFitness" + Program.evo.Generation.ToString() + ".mat','realFitness')");

            //matlab.Execute(@"exit");

            //MLDouble matlabMapDouble = new MLDouble("Double", new double[] { double.MaxValue, double.MinValue }, 1);

            //List<MLArray> mlList = new List<MLArray>();
            //mlList.Add(matlabMapDouble);

            //string filename = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\map";
            //MatFileWriter mfw = new MatFileWriter(filename, mlList, true);
        }
    }
}
