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
using System.Text.RegularExpressions;

namespace ChartViewing
{
    public partial class Form1 : Form
    {
        bool line = false;
        public List<FileInfo> files = new List<FileInfo>();
        public List<FileInfo> acfiles = new List<FileInfo>();

        List<Series> Paretoseries = new List<Series>();

        int updateSeriesLocation = 0;


        bool paretoHide = true;

        String pfPath;
        String FunPath;

        public Form1()
        {
            InitializeComponent();
            GetPfAndFUNlocation();
            InitializeParetoFrontLocation();
            InitializeSolutionLocation();
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

        public void InitializeSolutionLocation()
        {
            DirectoryInfo dir = new DirectoryInfo(FunPath);

            try
            {
                foreach (FileInfo f in dir.GetFiles("*"))
                {
                    //Debug.WriteLine("File {0}", f.FullName);
                    acfiles.Add(f);

                }
            }
            catch
            {
                Console.WriteLine("Directory {0}  \n could not be accessed!!!!", dir.FullName);
                return;  // We alredy got an error trying to access dir so dont try to access it again
            }

            acutalSolutionCombo.DataSource = acfiles;
            acutalSolutionCombo.DisplayMember = "Name";
            acutalSolutionCombo.ValueMember = "FullName";
            acutalSolutionCombo.DropDownStyle = ComboBoxStyle.DropDownList;
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

        public List<double[]>  getGenerationData(string fileName) 
        {

            StreamReader reader;
            try {
                //reader = new StreamReader(File.OpenRead(@"abcGenerations\generation"+generationNo));
                reader = new StreamReader(File.OpenRead(fileName));
            }
             catch (Exception ex) {
                 MessageBox.Show("failed to find the file " + ex.Message);
                 return null;
            }

            List<double[]> solutions = new List<double[]>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                string[] values = Regex.Split(line.Trim(), @"\s+");
                double []objectives=new double[values.Length];

                //Debug.WriteLine(line.ToString());
                //Debug.WriteLine(values.Length);



                for(int i=0;i<values.Length;i++)
                {
                   // Debug.WriteLine(values[i]);
                    objectives[i]=Convert.ToDouble(values[i].Trim());
                   // Debug.WriteLine(objectives[i]);
                }

                solutions.Add(objectives);

            }

            reader.Close();

            return solutions;
        }

        public void drawGeneration()
        {

            int upto=chart1.Series.Count;

            for (int i = updateSeriesLocation; i <upto ; i++)
            {
                chart1.Series.RemoveAt(updateSeriesLocation);
            }

            List<double[]> solutions = getGenerationData((string)acutalSolutionCombo.SelectedValue);


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

        private void button3_Click(object sender, EventArgs e)
        {

            line = !line;

            
            if (paretoHide)
            {
                drawGeneration();
            }
            else {                    
                drawParetoFront();
            }

                
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


            string howMany = takeParetoSolutionTextBox.Text;

            double takeSolution = 0;

            try
            {
                takeSolution = Convert.ToDouble(howMany);
            }
            catch (Exception e){
                MessageBox.Show("Enter valid no");
                Environment.Exit(0);
            }

            double count = 0;


            while (!reader.EndOfStream)
            {

                if (count == takeSolution &&  count >0) break;

                var line = reader.ReadLine();

                string[] values = Regex.Split(line.Trim(), @"\s+");
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

                count += 1;

            }

            reader.Close();

            return solutions;
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            paretoHide = false;
            textBox2.Text += (string)comboBox1.SelectedText+ "\r\n";
            drawParetoFront();            
        }

        private void acutalSolutionCombo_SelectionChangeCommitted(object sender, EventArgs e)
        {
            
            textBox2.Text += (string)acutalSolutionCombo.SelectedText + "\r\n";
            drawGeneration();
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
                //solutionSeries.Color = Color.Black;
                //chart1.Palette = ChartColorPalette.Fire;

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
                button4.Text = "Hide";
            }
            else
            {
                chart1.Series.Clear();
                updateSeriesLocation = 0;
                drawGeneration();
                button4.Text = "Show";
                
            }

            paretoHide = !paretoHide;


        }

        

        private void takeParetoSolutionTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                paretoHide = false;
                drawParetoFront();
            }
        }

       
        



    }
}
