class Diamond < Formula
  desc "Accelerated BLAST compatible local sequence aligner"
  homepage "http://ab.inf.uni-tuebingen.de/software/diamond/"
  # doi "10.1038/nmeth.3176"
  # tag "bioinformatics"

  url "https://github.com/bbuchfink/diamond/archive/v0.7.11.tar.gz"
  version "0.7.11"
  sha256 "e486bed71d5ea1f73c6016504cf137b74ff710422bb7f0038e16360bfb00b2f5"

  bottle do
    sha256 "e486bed71d5ea1f73c6016504cf137b74ff710422bb7f0038e16360bfb00b2f5" => :yosemite
    sha256 "da0750e96465902fbd7827dc2220c2cb298f71ae488d6175885eb2044e2066ad" => :mavericks
    sha256 "459c5a98274de600b7a270e51a589c21bae1add6384fe76d4a4b5c3d988778cb" => :mountain_lion
  end

  depends_on "boost"

  def install
    Dir.chdir("src") do
      inreplace "Makefile", "-Iboost/include", "-I#{Formula["boost"].include}"
      inreplace "Makefile", "LIBS=-l", "LIBS=-L#{Formula["boost"].lib} -l"
      inreplace "Makefile", "-lboost_thread", "-lboost_thread-mt"
      system "make"
    end
    bin.install "bin/diamond"
    doc.install "README.rst"
  end

  test do
    assert_match "gapextend", shell_output("diamond -h 2>&1", 0)
  end
end
