using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Keepaway
{
    public class EliteMap
    {
        // properties
        
        public static int numDimensions = 3;

        public static int[] dimensionsMin = new int[numDimensions];
        public static int[] dimensionsMax = new int[numDimensions];
        public static string[] dimensionNames = new string[numDimensions]; // teamDispersion, no_passes, distfromcentre

        public int[] elementResolution = new int[numDimensions];

        public MapElement[,,] Map = new MapElement[dimensionsMax[0], dimensionsMax[1], dimensionsMax[2]]; // teamDispersion, no_passes, distfromcentre


        // methods

        public EliteMap()
        {
            // initialise properties
            dimensionNames[0] = "teamDispersion";
            dimensionNames[1] = "no_passes";
            dimensionNames[2] = "distfromcentre";

            dimensionsMin[0] = 0;
            dimensionsMin[1] = 0;
            dimensionsMin[2] = 0;

            dimensionsMax[0] = 100000;
            dimensionsMax[1] = 100000;
            dimensionsMax[2] = 100000;

            elementResolution[0] = 10;
            elementResolution[1] = 10;
            elementResolution[2] = 10;

            // Initialise map
            for (int dimensionIndex0 = 0; dimensionIndex0 < dimensionsMax[0]/elementResolution[0]; ++dimensionIndex0)
            {
                for (int dimensionIndex1 = 0; dimensionIndex1 < dimensionsMax[1]/elementResolution[1]; ++dimensionIndex1)
                {
                    for (int dimensionIndex2 = 0; dimensionIndex2 < dimensionsMax[2]/elementResolution[2]; ++dimensionIndex2)
                    {
                        // create local vars for new genome to fill element, and position vector for element
                        NetworkGenome newGenome = new NetworkGenome();
                        int[] position = new int[3];
                        position[0] = dimensionIndex0;
                        position[1] = dimensionIndex1;
                        position[2] = dimensionIndex2;

                        // initialise MapElement for each element in the Map
                        Map[dimensionIndex0, dimensionIndex1, dimensionIndex2] = new MapElement(newGenome, position);
                    }
                }
            }
            // Now we have a map of default genomes
        }

        public void updateMapElement(NetworkGenome genome, int[] position)
        {
            Map[position[0], position[1], position[2]].genome = genome;
        }
    }
}
