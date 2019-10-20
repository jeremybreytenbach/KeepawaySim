using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
        
        private void writeToFile()
        {

        }
    }
}
