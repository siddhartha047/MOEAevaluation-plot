namespace ChartViewing
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea3 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend3 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series3 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.chart1 = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.takeParetoSolutionTextBox = new System.Windows.Forms.TextBox();
            this.acutalSolutionCombo = new System.Windows.Forms.ComboBox();
            this.button4 = new System.Windows.Forms.Button();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.button3 = new System.Windows.Forms.Button();
            this.trackBar1 = new System.Windows.Forms.TrackBar();
            this.from = new System.Windows.Forms.TextBox();
            this.to = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.chart1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.trackBar1)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.splitContainer2);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.button1);
            this.splitContainer1.Panel2.Controls.Add(this.to);
            this.splitContainer1.Panel2.Controls.Add(this.from);
            this.splitContainer1.Panel2.Controls.Add(this.trackBar1);
            this.splitContainer1.Panel2.Controls.Add(this.takeParetoSolutionTextBox);
            this.splitContainer1.Panel2.Controls.Add(this.acutalSolutionCombo);
            this.splitContainer1.Panel2.Controls.Add(this.button4);
            this.splitContainer1.Panel2.Controls.Add(this.comboBox1);
            this.splitContainer1.Panel2.Controls.Add(this.button3);
            this.splitContainer1.Size = new System.Drawing.Size(993, 599);
            this.splitContainer1.SplitterDistance = 502;
            this.splitContainer1.TabIndex = 0;
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 0);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.chart1);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.textBox2);
            this.splitContainer2.Size = new System.Drawing.Size(991, 500);
            this.splitContainer2.SplitterDistance = 907;
            this.splitContainer2.TabIndex = 1;
            // 
            // chart1
            // 
            chartArea3.AxisX.MajorGrid.Enabled = false;
            chartArea3.AxisY.MajorGrid.Enabled = false;
            chartArea3.Name = "ChartArea1";
            this.chart1.ChartAreas.Add(chartArea3);
            this.chart1.Dock = System.Windows.Forms.DockStyle.Fill;
            legend3.Name = "Legend1";
            this.chart1.Legends.Add(legend3);
            this.chart1.Location = new System.Drawing.Point(0, 0);
            this.chart1.Name = "chart1";
            series3.ChartArea = "ChartArea1";
            series3.Legend = "Legend1";
            series3.Name = "Series1";
            this.chart1.Series.Add(series3);
            this.chart1.Size = new System.Drawing.Size(907, 500);
            this.chart1.TabIndex = 0;
            this.chart1.Text = "chart1";
            // 
            // textBox2
            // 
            this.textBox2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.textBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.textBox2.Location = new System.Drawing.Point(0, 0);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox2.Size = new System.Drawing.Size(80, 500);
            this.textBox2.TabIndex = 4;
            this.textBox2.WordWrap = false;
            // 
            // takeParetoSolutionTextBox
            // 
            this.takeParetoSolutionTextBox.Location = new System.Drawing.Point(288, 7);
            this.takeParetoSolutionTextBox.Name = "takeParetoSolutionTextBox";
            this.takeParetoSolutionTextBox.Size = new System.Drawing.Size(67, 22);
            this.takeParetoSolutionTextBox.TabIndex = 13;
            this.takeParetoSolutionTextBox.Text = "250";
            this.takeParetoSolutionTextBox.KeyDown += new System.Windows.Forms.KeyEventHandler(this.takeParetoSolutionTextBox_KeyDown);
            // 
            // acutalSolutionCombo
            // 
            this.acutalSolutionCombo.FormattingEnabled = true;
            this.acutalSolutionCombo.Location = new System.Drawing.Point(728, 0);
            this.acutalSolutionCombo.Name = "acutalSolutionCombo";
            this.acutalSolutionCombo.Size = new System.Drawing.Size(132, 24);
            this.acutalSolutionCombo.TabIndex = 12;
            this.acutalSolutionCombo.SelectionChangeCommitted += new System.EventHandler(this.acutalSolutionCombo_SelectionChangeCommitted);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(156, 3);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(113, 31);
            this.button4.TabIndex = 11;
            this.button4.Text = "Hide/Show";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // comboBox1
            // 
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(3, 3);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(147, 24);
            this.comboBox1.TabIndex = 9;
            this.comboBox1.SelectionChangeCommitted += new System.EventHandler(this.comboBox1_SelectionChangeCommitted);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(860, 0);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(131, 31);
            this.button3.TabIndex = 8;
            this.button3.Text = "Line/Point";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // trackBar1
            // 
            this.trackBar1.Location = new System.Drawing.Point(-1, 40);
            this.trackBar1.Maximum = 250;
            this.trackBar1.Name = "trackBar1";
            this.trackBar1.Size = new System.Drawing.Size(800, 56);
            this.trackBar1.TabIndex = 14;
            this.trackBar1.Scroll += new System.EventHandler(this.trackBar1_Scroll);
            // 
            // from
            // 
            this.from.Location = new System.Drawing.Point(392, 7);
            this.from.Name = "from";
            this.from.Size = new System.Drawing.Size(88, 22);
            this.from.TabIndex = 15;
            // 
            // to
            // 
            this.to.Location = new System.Drawing.Point(497, 7);
            this.to.Name = "to";
            this.to.Size = new System.Drawing.Size(76, 22);
            this.to.TabIndex = 16;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(594, 7);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(66, 22);
            this.button1.TabIndex = 17;
            this.button1.Text = "OK";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(993, 599);
            this.Controls.Add(this.splitContainer1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            this.splitContainer2.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
            this.splitContainer2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.chart1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.trackBar1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.DataVisualization.Charting.Chart chart1;
        private System.Windows.Forms.SplitContainer splitContainer2;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.ComboBox acutalSolutionCombo;
        private System.Windows.Forms.TextBox takeParetoSolutionTextBox;
        private System.Windows.Forms.TrackBar trackBar1;
        private System.Windows.Forms.TextBox to;
        private System.Windows.Forms.TextBox from;
        private System.Windows.Forms.Button button1;
    }
}

