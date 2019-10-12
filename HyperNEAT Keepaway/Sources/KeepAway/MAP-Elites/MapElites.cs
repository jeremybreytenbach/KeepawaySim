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
        }

        public void updateMap(List<NetworkGenome> genomes)
        {
            // loop through each genome in list and add to appropriate position in eliteMap.Map
            for (int i = 0; i < genomes.Count; i++)
            {
                // check where genome fits into map


                // check if genome is better
                bool isbetterGenome = eliteMap.compareGenome(genomes[i], position);

                if (isbetterGenome)
                {
                    eliteMap.updateMapElement(genomes[i], position);
                }
                
                eliteMap.updateMapElement(genomes[i], position);
            }
        }
        
        private void writeToFile()
        {

        }
    }
}
