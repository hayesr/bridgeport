class Page < AbstractDocument
  include Mongoid::Versioning
  # include Mongoid::Tree
  # include Mongoid::Tree::Ordering # => Adds default scope asc(:position)
  include Mongoid::Ancestry
  include Sluggable
  
  has_ancestry
  
  field :title
  field :layout
  field :position
  field :grants, :type => Hash, :default => {}
  
  embeds_many :regions
  accepts_nested_attributes_for :regions, autosave: true, allow_destroy: true
  
  # default_scope asc(:position)
  
  before_save :clean_title
  
  class << self
    def home_page
      where(title: 'Home').first
    end
    
    def process_positions(params)
      tree = organize_position_params(params)
      position_branches(tree)
    end
    
  end
  
  def sorted_regions
    regions.asc(:position)
  end
  
  def clean_title
    write_attribute :title, title.strip
  end
  
  private
  
  def self.organize_position_params(params)
    tree = {}
    params.each do |k,v|
      if tree[v].nil?
        tree[v] = [k]
      else
        tree[v] << k
      end
    end
    tree
  end
  
  def self.position_branches(tree)
    tree.each do |branch, leaves|
      leaves.each_with_index do |iden, i|
        # binding.pry
        unless branch.nil?
          if branch == 'root'
            daddy = nil
          else
            daddy = find(branch)
          end
          # where(_id: id).update_all(parent: parent, position: i)
          # where(_id: id).update(parent: parent, position: i)
          leaf = find(iden)
          leaf.parent = daddy
          leaf.position = i
          leaf.save
        end
      end
    end
    # binding.pry
  end
  
  # {
  #   "4fb290b74ef1b7664e00001f"=>"root",
  #   "4fb2a10a4ef1b7664e00002e"=>"root",
  #   "4fb2a1244ef1b7664e000032"=>"root",
  #   "4fb2a04e4ef1b7664e00002a"=>"root",
  #   "4fb29e934ef1b7664e000026"=>"root",
  #   "4fb31a054ef1b7764e00000e"=>"4fb29e934ef1b7664e000026",
  #   "4fb31a954ef1b7764e000016"=>"4fb29e934ef1b7664e000026",
  #   "4fab42a54ef1b765ee000001"=>"root"
  # }
  #    4fb2be8b4ef1b7664e000043
  
end