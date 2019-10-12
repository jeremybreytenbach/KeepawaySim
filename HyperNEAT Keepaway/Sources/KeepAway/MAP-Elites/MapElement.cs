using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Keepaway
{
    public class MapElement
    {
        // properties

        public NetworkGenome genome; // store the genome itself
        public int[] position = new int[3]; // x,y,z position, eg 0,0,0 or 0,3,1 etc.
        public double fitness; // should update this everytime genome changes
        public double genomeId;// should update this everytime genome changes

        // methods
        public MapElement(NetworkGenome genome, int[] position)
        {
            this.genome = genome;
            this.position = position;

            this.fitness = genome.Fitness;
            this.genomeId = genome.Id;
        }
    }
}
