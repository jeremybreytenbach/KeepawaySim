using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using csmatio.types;
using csmatio.io;
using MLApp;

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

                // round each dimension
                teamDispersion = Math.Round(teamDispersion);
                no_passes = Math.Round(no_passes);
                distfromcentre = Math.Round(distfromcentre);

                // update EliteMap max to new max if necessary
                //if (teamDispersion > EliteMap.dimensionsMax[0])
                //{
                //    EliteMap.dimensionsMax[0] = (int)teamDispersion;
                //}
                //if (no_passes > EliteMap.dimensionsMax[1])
                //{
                //    EliteMap.dimensionsMax[1] = (int)no_passes;
                //}
                //if (distfromcentre > EliteMap.dimensionsMax[2])
                //{
                //    EliteMap.dimensionsMax[2] = (int)distfromcentre;
                //}

                // update EliteMap min to new min if necessary
                //if (teamDispersion < EliteMap.dimensionsMin[0])
                //{
                //    EliteMap.dimensionsMin[0] = (int)teamDispersion;
                //}
                //if (no_passes < EliteMap.dimensionsMin[1])
                //{
                //    EliteMap.dimensionsMin[1] = (int)no_passes;
                //}
                //if (distfromcentre < EliteMap.dimensionsMin[2])
                //{
                //    EliteMap.dimensionsMin[2] = (int)distfromcentre;
                //}

                int[] position = new int[3]; // x,y,z position, eg 0,0,0 or 0,3,1 etc.
                //position[0] = (EliteMap.dimensionsMax[0] - EliteMap.dimensionsMin[0]) / eliteMap.elementResolution[0] - 1;
                //position[1] = (EliteMap.dimensionsMax[1] - EliteMap.dimensionsMin[1]) / eliteMap.elementResolution[1] - 1;
                //position[2] = (EliteMap.dimensionsMax[2] - EliteMap.dimensionsMin[2]) / eliteMap.elementResolution[2] - 1;
                position[0] = (int)teamDispersion - 1;
                position[1] = (int)no_passes - 1;
                position[2] = (int)distfromcentre - 1;

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
            double[,] fitness = new double[100, 100];

            // initialise matlab interface
            MLApp.MLApp matlab = new MLApp.MLApp();

            //foreach (MapElement mapElement in this.eliteMap.Map)
            for (int z = 0; z < 100; z++)
            {
                for (int r = 0; r < 100; r++)
                {
                    for (int c = 0; c < 100; c++)
                    {
                        fitness[r, c] = this.eliteMap.Map[r, c, z].fitness;
                    }
                }
                // place each layer of fitness into matlab base workspace with a new name
                matlab.PutFullMatrix("fitness_" + z.ToString(), "base", fitness, fitness);
            }

            //matlab.Execute(@"for k = 0:99; save(sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness%i.mat',k),sprintf('fitness_%i',k)); end");

            matlab.Execute(@"for k = 0:99;fitness(1:100,1:100,k+1) =  eval(sprintf('fitness_%i',k));end");
            matlab.Execute(@"save('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\fitness.mat','fitness')");

            //MLDouble matlabMapDouble = new MLDouble("Double", new double[] { double.MaxValue, double.MinValue }, 1);

            //List<MLArray> mlList = new List<MLArray>();
            //mlList.Add(matlabMapDouble);

            //string filename = "E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\map";
            //MatFileWriter mfw = new MatFileWriter(filename, mlList, true);
        }
    }
}
