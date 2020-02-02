﻿using System;
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

        public static double[] dimensionsMin = new double[numDimensions];
        public static double[] dimensionsMax = new double[numDimensions];
        public static string[] dimensionNames = new string[numDimensions]; // teamDispersion, no_passes, distfromcentre

        public double[] elementResolution = new double[numDimensions];

        //public MapElement[,,] Map = new MapElement[dimensionsMax[0], dimensionsMax[1], dimensionsMax[2]]; // teamDispersion, no_passes, distfromcentre
        public MapElement[,,] Map = new MapElement[100, 100, 100]; // teamDispersion, no_passes, distfromcentre
        public List<NetworkGenome> flatMap = new List<NetworkGenome>();

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

            dimensionsMax[0] = 100;
            dimensionsMax[1] = 100;
            dimensionsMax[2] = 100;

            elementResolution[0] = 1;
            elementResolution[1] = 1;
            elementResolution[2] = 1;

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
            // replace genome at position with new specified genome
            Map[position[0], position[1], position[2]].genome = genome;
            Map[position[0], position[1], position[2]].fitness = genome.Fitness;
            Map[position[0], position[1], position[2]].position = position;
            Map[position[0], position[1], position[2]].genomeId = genome.Id;
            flatMap.Add(genome);
        }

        public bool compareGenome(NetworkGenome genome, int[] position)
        {
            if (genome.Fitness > Map[position[0], position[1], position[2]].fitness) 
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
    }
}