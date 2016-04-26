using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Windows.Forms.DataVisualization.Charting;
using System.Diagnostics;

namespace ChartViewing
{
    public partial class Form1 : Form
    {
        bool line = false;
        public List<FileInfo> files = new List<FileInfo>();

        List<Series> Paretoseries = new List<Series>();

        int updateSeriesLocation = 0;


        bool paretoHide = true;

        String pfPath;
        String FunPath;

        public Form1()
        {
            InitializeComponent();
            GetPfAndFUNlocation();
            InitializeOtherComponent();
            InitializeParetoFrontLocation();
            InitializeChart();

            

        }

        public void GetPfAndFUNlocation() { 
            StreamReader locationReader;
            try {
                locationReader = new StreamReader(File.OpenRead(@"Location.txt"));
                pfPath = locationReader.ReadLine();
                FunPath = locationReader.ReadLine();
            }
             catch (Exception ex) {
                 MessageBox.Show("failed to find the file " + ex.Message);
            }
        }

        public void InitializeChart()
        {
        
            chart1.ChartAreas["ChartArea1"].CursorX.AutoScroll = true;
            chart1.ChartAreas["ChartArea1"].CursorY.AutoScroll = true;

            // Allow user selection for Zoom
            chart1.ChartAreas["ChartArea1"].CursorX.IsUserSelectionEnabled = true;
            chart1.ChartAreas["ChartArea1"].CursorY.IsUserSelectionEnabled = true;

            chart1.Series.Clear();
            Paretoseries.Clear();
        }

        public void InitializeOtherComponent()
        {

            trackBar1.Minimum = 1;
            trackBar1.Maximum = 500;
            trackBar1.TickFrequency = 1;
            trackBar1.TickStyle = TickStyle.Both;

        }

        public void InitializeParetoFrontLocation() 
        {
            DirectoryInfo dir = new DirectoryInfo(pfPath);

            try
            {
                foreach (FileInfo f in dir.GetFiles("*"))
                {
                    //Debug.WriteLine("File {0}", f.FullName);
                    files.Add(f);
                    
                }
            }
            catch
            {
                Console.WriteLine("Directory {0}  \n could not be accessed!!!!", dir.FullName);
                return;  // We alredy got an error trying to access dir so dont try to access it again
            }

            comboBox1.DataSource = files;
            comboBox1.DisplayMember = "Name";
            comboBox1.ValueMember = "FullName";
            comboBox1.DropDownStyle = ComboBoxStyle.DropDownList;

        }
        public List<double[]>  getGenerationData(int generationNo) 
        {

            StreamReader reader;
            try {
                //reader = new StreamReader(File.OpenRead(@"abcGenerations\generation"+generationNo));
                reader = new StreamReader(File.OpenRead(FunPath));
            }
             catch (Exception ex) {
                 MessageBox.Show("failed to find the file " + ex.Message);
                 return null;
            }

            List<double[]> solutions = new List<double[]>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                string[] values=line.Trim().Split(' ');
                double []objectives=new double[values.Length];

                //Debug.WriteLine(line.ToString());
                //Debug.WriteLine(values.Length);



                for(int i=0;i<values.Length;i++)
                {
                   // Debug.WriteLine(values[i]);
                    objectives[i]=Convert.ToDouble(values[i]);
                   // Debug.WriteLine(objectives[i]);
                }

                solutions.Add(objectives);

            }

            reader.Close();

            return solutions;
        }

        public void drawGeneration(int generationNo)
        {

            int upto=chart1.Series.Count;

            for (int i = updateSeriesLocation; i <upto ; i++)
            {
                chart1.Series.RemoveAt(updateSeriesLocation);
            }

            List<double[]> solutions=getGenerationData(generationNo);


            for(int i=0;i<solutions.Count;i++)
            { 
                double []solution=solutions[i];
                

                Series solutionSeries = new Series(i.ToString());
                solutionSeries.Points.DataBindY(solution);
                if (line)
                {
                    solutionSeries.ChartType = SeriesChartType.Line;
                }
                else
                {
                    solutionSeries.ChartType = SeriesChartType.Point;
                    solutionSeries.MarkerStyle = MarkerStyle.Circle;
                    solutionSeries.MarkerSize = 5;
                }
                
                solutionSeries.IsVisibleInLegend = false; 
                chart1.Series.Add(solutionSeries);                

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string generationNo = (string)textBox1.Text;
            int generation = 1;
            try
            {
                generation = Convert.ToInt32(generationNo);
            }
            catch {
                MessageBox.Show("Enter valid generation");
                return;
            }

            drawGeneration(generation);

        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {
           drawGeneration(trackBar1.Value);
           //Debug.WriteLine(trackBar1.Value);
           textBox2.Text += trackBar1.Value + "\r\n";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string trackerMax = (string)textBox3.Text;
            int  track = 100;
            try
            {
                track = Convert.ToInt32(trackerMax);
            }
            catch
            {
                MessageBox.Show("Enter valid generation");
                return;
            }

            trackBar1.Maximum = track;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (line)
                line = false;
            else
                line = true;

          //  drawParetoFront();
          //  drawGeneration(trackBar1.Value);
        }

        public List<double[]>  getParetoSolution(string path) 
        {

            StreamReader reader;
            try {
                reader = new StreamReader(File.OpenRead(path));
            }
            catch (Exception ex) {
                 MessageBox.Show("failed to find the file " + ex.Message);
                 return null;
            }

            List<double[]> solutions = new List<double[]>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                
                string[] values=line.Trim().Split(' ');
                double []objectives=new double[values.Length];

                Debug.WriteLine(line.ToString());
                Debug.WriteLine(values.Length);



                for(int i=0;i<values.Length;i++)
                {
                   // Debug.WriteLine(values[i]);
                    objectives[i]=Convert.ToDouble(values[i]);
                   // Debug.WriteLine(objectives[i]);
                }

                solutions.Add(objectives);

            }

            reader.Close();

            return solutions;
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            textBox2.Text += (string)comboBox1.SelectedText+ "\r\n";
            drawParetoFront();
            //drawGeneration(trackBar1.Value);
        }


        public void drawParetoFront()
        {
            chart1.Series.Clear();
            
            
            List<double[]> solutions=getParetoSolution((string)comboBox1.SelectedValue);
            for (int i = 0; i < solutions.Count; i++)
            {
                double[] solution = solutions[i];


                Series solutionSeries = new Series("pareto "+i.ToString());
                solutionSeries.Points.DataBindY(solution);
                if (line)
                {
                    solutionSeries.ChartType = SeriesChartType.Line;
                }
                else
                {
                    solutionSeries.ChartType = SeriesChartType.Point;
                    solutionSeries.MarkerStyle = MarkerStyle.Circle;
                    solutionSeries.MarkerSize = 5;
                }

                solutionSeries.IsVisibleInLegend = false;
                solutionSeries.Color = Color.Black;
                chart1.Series.Add(solutionSeries);
                
            }

            updateSeriesLocation = chart1.Series.Count;

        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (paretoHide)
            {
                chart1.Series.Clear();
                drawParetoFront();
                drawGeneration(trackBar1.Value);
                paretoHide = false;
            }
            else
            {
                chart1.Series.Clear();
                updateSeriesLocation = 0;
                drawGeneration(trackBar1.Value);
                paretoHide = true;
            }



        }
        



    }
}
