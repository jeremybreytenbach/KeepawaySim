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
        public static int dimensionMax = 100;

        public static double[] dimensionsMin = new double[numDimensions];
        public static double[] dimensionsMax = new double[numDimensions];
        public static string[] dimensionNames = new string[numDimensions]; // teamDispersion, no_passes, distfromcentre

        public double[] elementResolution = new double[numDimensions];

        //public MapElement[,,] Map = new MapElement[dimensionsMax[0], dimensionsMax[1], dimensionsMax[2]]; // teamDispersion, no_passes, distfromcentre
        public MapElement[,,] Map = new MapElement[dimensionMax, dimensionMax, dimensionMax]; // teamDispersion, no_passes, distfromcentre
        public List<NetworkGenome> flatMap = new List<NetworkGenome>(); // add property to NetworkGenome as eliteMapPosition  int[] position -> 3 numbers

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

            dimensionsMax[0] = dimensionMax;
            dimensionsMax[1] = dimensionMax;
            dimensionsMax[2] = dimensionMax;

            elementResolution[0] = 1;
            elementResolution[1] = 1;
            elementResolution[2] = 1;

            // Initialise map
            // don't initialise map
            for (int dimensionIndex0 = 0; dimensionIndex0 < dimensionsMax[0]/elementResolution[0]; ++dimensionIndex0) // eg. 100/0.1 => 0,1,2,...,1000
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

        public void updateMapElement(NetworkGenome genome, int[] position) // rather - I need to only have a flat map. So find the flatmap item that has position, and update that one.
        {
            // flatMap[findMapElement(position)].genome = genome; etc.
            // replace genome at position with new specified genome
            Map[position[0], position[1], position[2]].genome = genome;
            Map[position[0], position[1], position[2]].realFitness = genome.RealFitness;
            Map[position[0], position[1], position[2]].fitness = genome.Fitness;
            Map[position[0], position[1], position[2]].position = position;
            Map[position[0], position[1], position[2]].genomeId = genome.Id;
            flatMap.Add(genome);
        }

        public bool compareGenome(NetworkGenome genome, int[] position)
        {
            // if genome.RealFitness > flatMap(findMapElement(position)).realFitness
            if (genome.RealFitness > Map[position[0], position[1], position[2]].realFitness) 
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

        //public int findMapElement(int[] position)
        //{
        //    // search flatMap and return index in flatmap of genome with flatmap.position = position
        //}
    }
}
