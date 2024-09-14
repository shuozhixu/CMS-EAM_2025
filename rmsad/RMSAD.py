import numpy as np
import os

def read_lammps_dump(filename):
    positions = []
    box_bounds = []
    with open(filename, 'r') as file:
        lines = file.readlines()
        is_atoms_section = False
        for i, line in enumerate(lines):
            if 'ITEM: BOX BOUNDS' in line:
                
                for j in range(1, 4):
                    bounds = lines[i + j].split()
                    box_bounds.append((float(bounds[0]), float(bounds[1])))
            if 'ITEM: ATOMS' in line:
                is_atoms_section = True
                continue
            if is_atoms_section:
                parts = line.split()
                if len(parts) >= 5:  
                    positions.append([float(parts[2]), float(parts[3]), float(parts[4])])
    return np.array(positions), box_bounds

def calculate_box_size(box_bounds):
    
    return [bounds[1] - bounds[0] for bounds in box_bounds]

def calculate_RMSAD(unrelaxed_positions, relaxed_positions, box_size):
    print(f"Unrelaxed positions shape: {unrelaxed_positions.shape}")
    print(f"Relaxed positions shape: {relaxed_positions.shape}")
    
    assert unrelaxed_positions.shape == relaxed_positions.shape, "Shape mismatch between unrelaxed and relaxed positions"
    
    # Apply periodic boundary condition corrections
    displacements = relaxed_positions - unrelaxed_positions
    for i in range(3):  
        displacements[:, i] -= np.rint(displacements[:, i] / box_size[i]) * box_size[i]
    
    # Calculate the magnitude of displacement vectors
    displacements_magnitude = np.sqrt(np.sum(displacements ** 2, axis=1))
    
    delta_d = np.mean(displacements_magnitude)
    return delta_d

#def save_delta_d(delta_d, save_folder, filename):
#    if not os.path.exists(save_folder):
#       os.makedirs(save_folder)  # Create the folder if it doesn't exist
#    file_path = os.path.join(save_folder, filename)
#    with open(file_path, 'w') as file:
#        file.write(f'Local lattice distortion (Δd): {delta_d}\n')
   

# File paths
unrelaxed_file = 'dump.pure_sorted'
relaxed_file = 'dump.alloy_sorted'

# Read positions and box bounds
unrelaxed_positions, unrelaxed_box_bounds = read_lammps_dump(unrelaxed_file)
relaxed_positions, _ = read_lammps_dump(relaxed_file)  # Assuming the box bounds are the same for both

# Calculate the box size from unrelaxed structure
box_size = calculate_box_size(unrelaxed_box_bounds)
print(f'Calculated box size: {box_size}')

# Calculate local lattice distortion
delta_d = calculate_RMSAD(unrelaxed_positions, relaxed_positions, box_size)

# Save the value of delta_d 
#save_folder = '../filepath'
#filename = 'lattice_distortion_result.txt'
#save_delta_d(delta_d, save_folder, filename)
print(f'RMSAD: {delta_d}')

