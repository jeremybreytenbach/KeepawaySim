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
        //public static int dimensionMax = 100;

        //public static double[] dimensionsMin = new double[numDimensions];
        //public static double[] dimensionsMax = new double[numDimensions];
        public static string[] dimensionNames = new string[numDimensions]; // teamDispersion, no_passes, distfromcentre

        //public double[] elementResolution = new double[numDimensions];

        //public MapElement[,,] Map = new MapElement[dimensionMax, dimensionMax, dimensionMax]; // teamDispersion, no_passes, distfromcentre
        public List<NetworkGenome> flatMap = new List<NetworkGenome>();

        // methods

        public EliteMap()
        {
            // initialise properties
            dimensionNames[0] = "teamDispersion";
            dimensionNames[1] = "no_passes";
            dimensionNames[2] = "distfromcentre";

            //dimensionsMin[0] = 0;
            //dimensionsMin[1] = 0;
            //dimensionsMin[2] = 0;

            //dimensionsMax[0] = dimensionMax;
            //dimensionsMax[1] = dimensionMax;
            //dimensionsMax[2] = dimensionMax;

            //elementResolution[0] = 1;
            //elementResolution[1] = 1;
            //elementResolution[2] = 1;

            // Initialise map
            //for (int dimensionIndex0 = 0; dimensionIndex0 < dimensionsMax[0]/elementResolution[0]; ++dimensionIndex0) // eg. 100/0.1 => 0,1,2,...,1000
            //{
            //    for (int dimensionIndex1 = 0; dimensionIndex1 < dimensionsMax[1]/elementResolution[1]; ++dimensionIndex1)
            //    {
            //        for (int dimensionIndex2 = 0; dimensionIndex2 < dimensionsMax[2]/elementResolution[2]; ++dimensionIndex2)
            //        {
            //            // create local vars for new genome to fill element, and position vector for element
            //            NetworkGenome newGenome = new NetworkGenome();
            //            int[] position = new int[3];
            //            position[0] = dimensionIndex0;
            //            position[1] = dimensionIndex1;
            //            position[2] = dimensionIndex2;

            //            // initialise MapElement for each element in the Map
            //            Map[dimensionIndex0, dimensionIndex1, dimensionIndex2] = new MapElement(newGenome, position);
            //        }
            //    }
            //}
            // Now we have a map of default genomes
        }

        public void updateMapElement(NetworkGenome genome, int[] position) // rather - I need to only have a flat map. So find the flatmap item that has position, and update that one.
        {
            int indFlatMap = findMapElement(position);
            genome.EliteMapPosition = position;

            if (indFlatMap == -1)
            {
                // if this position is empty, add this genome to the list
                flatMap.Add(genome);
            }
            else
            {
                // if this position is already filled, replace that genome with this one
                flatMap[indFlatMap] = genome;
            }
        }

        public bool compareGenome(NetworkGenome genome, int[] position)
        {
            int indFlatMap = findMapElement(position);
            if (indFlatMap  == -1)
            {
                return true; // return true if this position in map is empty
            }
            else if (genome.RealFitness > flatMap[indFlatMap].RealFitness)
            {
                return true; // return true if passed in genome is greater than existing genome at that location
            }
            else
            {
                return false;
            }
        }

        public int numElements()
        {
            //return this.Map.Count(s => s != null);
            return this.flatMap.Count();
        }

        public int findMapElement(int[] position)
        {
            // search flatMap and return index in flatmap of genome with flatmap.position = position
            return flatMap.FindIndex(i => i.EliteMapPosition[0] == position[0] & i.EliteMapPosition[1] == position[1] & i.EliteMapPosition[2] == position[2]);
        }
    }
}
